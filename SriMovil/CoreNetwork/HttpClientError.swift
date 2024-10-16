//
//  HttpClientError.swift
//  SriMovil
//
//  Created by usradmin on 14/10/24.
//

import Foundation

enum HttpClientError: Error {
    case badURL
    case requestFailed(Error)
    case statusError(Int)
    case clientError(String?, Int)  // Client-side errors (4xx)
    case serverError(String?, Int)  // Server-side errors (5xx)
    case decodingError(Error)
    case unknownError
    case parsingError(String)
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            return "La URL proporcionada no es válida."
        case .requestFailed(let error):
            return "La solicitud falló y se produjo un error: \(error.localizedDescription)"
        case .statusError(let statusCode):
            return "La solicitud falló con el código de estado: \(statusCode)"
        case .clientError(let message, let statusCode):
            return message ?? "Error de cliente con código de estado: \(statusCode)"
        case .serverError(let message, let statusCode):
            return message ?? "Error del servidor con código de estado: \(statusCode)"
        case .decodingError(let error):
            return "Error de decodificación: \(error.localizedDescription)"
        case .unknownError:
            return "Un error desconocido ocurrió."
        case .parsingError(let errorDescription):
            return "Parsing error: \(errorDescription)"
        }
    }
}
