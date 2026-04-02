//
//  NetworkService.swift
//  SriMovil
//
//  Created by usradmin on 25/3/26.
//

import Foundation

final class NetworkService: NetworkServiceProtocol, Sendable {
    
    // MARK: - Private Properties
    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder
    
    /// SSL Pinning delegate (retained by URLSession)
    private let pinningDelegate: SSLPinningDelegate?
    
    // MARK: Initializers
    
    init(
        baseURL: URL = URL(string: API.baseURL)!,
        session: URLSession? = nil,
        enableSSLPinning: Bool = true
    ) {
        self.baseURL = baseURL
        
        // SSL Pinning is disabled for test server — enable for production
        let delegate = enableSSLPinning ? SSLPinningDelegate(
            pinnedHashes: [],
            isPinningEnabled: false
        ): nil
        
        self.pinningDelegate = delegate
        
        if let session {
            self.session = session
        } else {
            self.session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
        }
        
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        //self.decoder.dateDecodingStrategy = .iso8601
        
        self.decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            
            if let timestamp = try? container.decode(Double.self) {
                return Date(timeIntervalSince1970: timestamp / 1000)
            }
            
            if let dateString = try? container.decode(String.self) {
                let isoFormatter = ISO8601DateFormatter()
                
                if let date = isoFormatter.date(from: dateString) {
                    return date
                }
            }
            
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Formato de fecha no soportado"
            )
        }
    }
    
    // MARK: - Functions
    
    func get<T: Decodable & Sendable>(endpoint: String) async throws -> T {
        guard let url = buildURL(from: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print("URL:", url.absoluteString)
        print("Headers:", request.allHTTPHeaderFields ?? [:])
        
        return try await perform(request)
    }
    
    // MARK: - Private Functions
    
    private func buildURL(from endpoint: String) -> URL? {
        let parts = endpoint.split(separator: "?", maxSplits: 1, omittingEmptySubsequences: false)
        
        let rawPath = String(parts[0])
        let rawQuery = parts.count > 1 ? String(parts[1]) : nil
        
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        let normalizedBasePath = components.path.hasSuffix("/")
        ? String(components.path.dropLast())
        : components.path
        
        let normalizedEndpointPath = rawPath.hasPrefix("/")
        ? rawPath
        : "/\(rawPath)"
        
        let fullPath = normalizedBasePath + normalizedEndpointPath
        
        components.percentEncodedPath = fullPath.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        ?? fullPath
        
        if let rawQuery, !rawQuery.isEmpty {
            components.queryItems = parseQueryItems(from: rawQuery)
        }
        
        return components.url
    }
    
    private func parseQueryItems(from rawQuery: String) -> [URLQueryItem] {
        rawQuery
            .split(separator: "&")
            .compactMap { pair in
                let elements = pair.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false)
                
                guard let name = elements.first, !name.isEmpty else {
                    return nil
                }
                
                let value: String?
                if elements.count > 1 {
                    value = String(elements[1]).removingPercentEncoding ?? String(elements[1])
                } else {
                    value = nil
                }
                
                return URLQueryItem(name: String(name), value: value)
            }
    }
    
    
    private func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        // Si aquí falla por: no internet, DNS no resuelve, servidor caído, timeout , SSL falla, da un URLError y no pasa al validateResponse()
        let(data, response) = try await session.data(for: request)
        print("Response:", response)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Body:", jsonString)
        }
        
        try validateResponse(data: data, response: response)
        return try decoder.decode(T.self, from: data)
    }
    
    private func validateResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 404:
            let contentType = httpResponse.value(forHTTPHeaderField: "Content-Type") ?? ""
            
            if contentType.localizedCaseInsensitiveContains("application/json"),
               let backError = try? decoder.decode(SRIErrorResponseDTO.self, from: data) {
                throw NetworkError.notFound(message: backError.mensaje)
            } else {
                throw NetworkError.serverError(httpResponse.statusCode)
            }
        case 406:
            throw NetworkError.notAcceptable
        case 422:
            throw NetworkError.validateError
        case 500...599:
            throw NetworkError.serverError(httpResponse.statusCode)
        default:
            throw NetworkError.unknown(httpResponse.statusCode)
        }
    }
}
