//
//  HTTPClient.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 3/8/24.
//

import Foundation
import Factory

class HTTPClient {
    @Injected(\.session) private var session
    
    func makeRequest(endPoint: EndPoint) async -> Result<Data, HttpClientError> {
        guard var urlComponents = URLComponents(string: endPoint.baseURL + endPoint.context + endPoint.path) else {
            return .failure(.badURL)
        }
        
        urlComponents.setQueryItems(with: endPoint.queryParameters)
        
        guard let url = urlComponents.url else {
            return .failure(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.setHTTPBody(with: endPoint.bodyParameters)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.unknownError)
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return .success(data)
            case 400...499:
                let apiError = try? JSONDecoder().decode(ApiError.self, from: data)
                return .failure(.clientError(apiError?.mensaje, httpResponse.statusCode))
            case 500...599:
                let apiError = try? JSONDecoder().decode(ApiError.self, from: data)
                return .failure(.serverError(apiError?.mensaje ?? "Server error", httpResponse.statusCode))
            default:
                return .failure(.statusError(httpResponse.statusCode))
            }
        } catch {
            return .failure(.requestFailed(error))
        }
    }
}

// Definición de ApiError para decodificar el mensaje de error del API
struct ApiError: Decodable {
    let codigo: String
    let mensaje: String
    let detalles: String?
}
