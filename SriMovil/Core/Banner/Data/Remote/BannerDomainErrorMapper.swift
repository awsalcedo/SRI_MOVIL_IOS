//
//  BannerDomainErrorMapper.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation

class BannerDomainErrorMapper {
    func map(error: HttpClientError) -> BannerDomainError {
        switch error {
        case .badURL:
            return .badURL
        case .requestFailed(let err):
            return .requestFailed(err.localizedDescription)
        case .statusError(let statusCode):
            return .statusError(statusCode)
        case .clientError(let message, let statusCode):
            return .clientError(message ?? "Error de cliente: \(statusCode)")
        case .serverError(let message, let statusCode):
            return .serverError(message ?? "Error del servidor con código de estado: \(statusCode)")
        case .decodingError(let err):
            return .decodingError(err.localizedDescription)
        case .unknownError:
            return .unknownError
        case .parsingError(let errDesc):
            return .parsingError(errDesc)
        }
    }
}
