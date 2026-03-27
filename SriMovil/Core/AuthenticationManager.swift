//
//  AuthenticationManager.swift
//  SriMovil
//
//  Created by usradmin on 15/11/24.
//

import Foundation

// MARK: - AuthenticationManagerProtocol

/// Protocolo para gestionar autenticación
protocol AuthenticationManagerProtocol {
    /// Función para  agregar headers de autenticación a la solicitud
    func addAuthenticationHeaders(to rquest: inout URLRequest, authType: AuthenticationType)
}

// MARK: - AuthenticationManager

/// Implementación del AuthenticationManagerProtocol
final class AuthenticationManager: AuthenticationManagerProtocol {
    func addAuthenticationHeaders(to request: inout URLRequest, authType: AuthenticationType) {
        switch authType {
        case .none:
            break
        case .token(let token):
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        case .credentials(let username, let password):
            let credentialData = "\(username):\(password)".data(using: .utf8)
            let base64Credentials = credentialData?.base64EncodedString() ?? ""
            request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        }
    }
}
