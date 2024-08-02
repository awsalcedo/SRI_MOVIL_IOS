//
//  VehiculosApi.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

class VehiculosApi: VehiculosApiType {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func makeRequest(endPoint: EndPoint) async -> Result<Data, HttpClientError> {
        guard let url = endPoint.url else {
            return .failure(HttpClientError.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(HttpClientError.unknownError)
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return .success(data)
            case 400...499:
                return .failure(HttpClientError.clientError)
            case 500...599:
                return .failure(HttpClientError.serverError)
            default:
                return .failure(HttpClientError.unknownError)
            }
        } catch {
            return .failure(HttpClientError.unknownError)
        }
    }
}

extension HTTPMethod {
    var rawValue: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}
