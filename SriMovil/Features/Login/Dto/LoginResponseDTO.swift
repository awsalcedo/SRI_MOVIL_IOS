//
//  LoginResponseDTO.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 16/4/26.
//

import Foundation

/// Representa la respuesta remota del endpoint de autenticación.
///
/// Este DTO modela exactamente el contrato JSON devuelto por el backend
/// durante el proceso de login.
///
/// Ejemplo de respuesta:
/// ```json
/// {
///   "contenido": "Token eyJhbGciOiJIUzUxMiJ9..."
/// }
/// ```
///
/// - Important:
/// Este tipo pertenece a la capa de transporte y no debe ser consumido
/// directamente por la UI.
struct LoginResponseDTO: Decodable, Sendable {
    
    /// Contenido retornado por el backend.
    ///
    /// En el endpoint actual, este valor contiene el token precedido
    /// por el prefijo `"Token "`.
    let contenido: String
}

extension LoginResponseDTO {
    
    /// Convierte el DTO remoto en un modelo limpio para la feature.
    ///
    /// - Returns: Resultado autenticado con el token normalizado.
    func toDomain() -> AuthenticatedSessionModel {
        AuthenticatedSessionModel(accessToken: normalizedAccessToken)
    }
    
    /// Token limpio derivado del contenido remoto.
    private var normalizedAccessToken: String {
        let trimmedValue = contenido.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmedValue.hasPrefix("Token ") else {
            return trimmedValue
        }
        
        return String(trimmedValue.dropFirst("Token ".count))
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
