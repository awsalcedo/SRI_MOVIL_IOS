//
//  HTTPClient.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 3/8/24.
//

import Foundation
import Factory

class HTTPClient {
    @Injected(\.urlSession) private var urlSession
    
    func makeRequest(endPoint: EndPoint) async -> Result<Data, HttpClientError> {
        guard let url = endPoint.url else {
            return .failure(HttpClientError.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(HttpClientError.unknownError)
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return .success(data)
            case 400...499:
                return .failure(.statusError(httpResponse.statusCode))
            case 500...599:
                return .failure(.statusError(httpResponse.statusCode))
            default:
                return .failure(.unknownError)
            }
            
        } catch {
            return .failure(HttpClientError.unknownError)
        }
    }
}
