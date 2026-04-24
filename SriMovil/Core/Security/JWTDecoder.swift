//
//  JWTDecoder.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Implementación concreta para decodificar localmente un JWT.
///
/// Este decoder interpreta el payload del token sin validar firma,
/// con el único propósito de recuperar claims necesarios para la UI
/// y la persistencia local de sesión.
///
/// - Important:
/// La autorización real sigue dependiendo del backend. Este decoder
/// no reemplaza mecanismos de validación de seguridad del servidor.
struct JWTDecoder: JWTDecoderProtocol {
    
    // MARK: - Error
    
    enum JWTDecodingError: LocalizedError {
        case invalidTokenStructure
        case invalidPayloadEncoding
        case invalidPayload
        
        var errorDescription: String? {
            switch self {
            case .invalidTokenStructure:
                return "El token no tiene una estructura JWT válida."
            case .invalidPayloadEncoding:
                return "No fue posible decodificar el payload del token."
            case .invalidPayload:
                return "El payload del token no contiene la información esperada."
            }
        }
    }
    
    // MARK: - DTO
    
    private struct JWTPayloadDTO: Decodable {
        let identificacion: String
        let razonSocial: String
        let validoHasta: Int64
    }
    
    // MARK: - Funciones
    
    func decode(token: String) throws -> LoginUserProfileModel {
        let components = token.split(separator: ".")
        
        guard components.count == 3 else {
            throw JWTDecodingError.invalidTokenStructure
        }
        
        let payloadPart = String(components[1])
        
        guard let data = payloadPart.base64URLDecodedData else {
            throw JWTDecodingError.invalidPayloadEncoding
        }
        
        guard let payload = try? JSONDecoder().decode(JWTPayloadDTO.self, from: data) else {
            throw JWTDecodingError.invalidPayload
        }
        
        return LoginUserProfileModel(
            identificacion: payload.identificacion,
            razonSocial: payload.razonSocial,
            validoHasta: payload.validoHasta
        )
    }
}
