//
//  InfoVehiculoDomainErrorMapper.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

class InfoVehiculoDomainErrorMapper {
    func map(error: HttpClientError) -> InfoVehiculoDomainError {
        switch error {
        case .badURL:
            return .badURL
        case .requestFailed(let err):
            return .requestFailed(err.localizedDescription)
        case .statusError(let statusCode):
            return .statusError(statusCode)
        case .clientError(_, let statusCode):
            return .clientError("Error de cliente con código de estado: \(statusCode)")
        case .serverError(_, let statusCode):
            return .serverError("Error del servidor con código de estado: \(statusCode)")
        case .decodingError(let err):
            return .decodingError(err.localizedDescription)
        case .unknownError:
            return .unknownError
        case .parsingError(let errDesc):
            return .parsingError(errDesc)
        }
    }
}
