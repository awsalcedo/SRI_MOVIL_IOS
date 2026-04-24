//
//  JWTDecoderProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Define el contrato para decodificar localmente el payload de un JWT.
///
/// Este protocolo permite abstraer la lógica de parsing del token,
/// facilitando pruebas unitarias y desacoplando la feature de login
/// de una implementación concreta.
protocol JWTDecoderProtocol: Sendable {
    
    /// Decodifica un token JWT y devuelve sus claims relevantes para la app.
    ///
    /// - Parameter token: Token JWT a decodificar.
    /// - Returns: Payload interpretado del token.
    func decode(token: String) throws -> LoginUserProfileModel
}
