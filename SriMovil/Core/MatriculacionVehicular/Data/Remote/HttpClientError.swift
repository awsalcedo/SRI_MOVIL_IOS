//
//  HttpClientError.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

enum HttpClientError: Error {
    case badURL
    case requestFailed(Error)
    case statusError(Int)
    case clientError(Data?, Int)  // Client-side errors (4xx)
    case serverError(Data?, Int)  // Server-side errors (5xx)
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
        case .clientError(_, let statusCode):
            return "Error de cliente con código de estado: \(statusCode)"
        case .serverError(_, let statusCode):
            return "Error del servidor con código de estado: \(statusCode)"
        case .decodingError(let error):
            return "Error de decodificación: \(error.localizedDescription)"
        case .unknownError:
            return "Un error desconocido ocurrió."
        case .parsingError(let errorDescription):
            return "Parsing error: \(errorDescription)"
        }
    }
}
