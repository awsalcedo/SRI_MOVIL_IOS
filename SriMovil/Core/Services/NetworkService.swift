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
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
    // MARK: - Functions
    
    func get<T: Decodable & Sendable>(endpoint: String) async throws -> T {
        let url = baseURL.appending(path: endpoint, directoryHint: .notDirectory)
        
        guard let url = URL(string: url.absoluteString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print("URL:", url.absoluteString)
        print("Headers:", request.allHTTPHeaderFields ?? [:])
        
        return try await perform(request)
    }
    
    // MARK: - Private Functions
    
    private func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        // Si aquí falla por: no internet, DNS no resuelve, servidor caído, timeout , SSL falla, da un URLError y no pasa al validateResponse()
        let(data, response) = try await session.data(for: request)
        print("Response:", response)
        
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
            let backError = try? decoder.decode(SRIErrorResponseDTO.self, from: data)
            throw NetworkError.notFound(message: backError?.mensaje)
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
