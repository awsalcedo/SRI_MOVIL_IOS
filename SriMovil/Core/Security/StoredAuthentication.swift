//
//  StoredAuthentication.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Representa la autenticación activa persistida localmente.
///
/// Este modelo almacena el token vigente y la fecha de expiración
/// utilizada para validar si la sesión todavía es válida.
///
/// - Important:
/// Este tipo contiene información sensible y debe almacenarse
/// en un medio seguro como Keychain.
struct StoredAuthentication: Codable, Sendable, Equatable {
    
    /// Token de acceso utilizado para solicitudes autenticadas.
    let accessToken: String
    
    /// Timestamp de expiración del token en milisegundos.
    let validoHasta: Int64
}
