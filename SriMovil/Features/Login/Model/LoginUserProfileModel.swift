//
//  LoginUserProfileModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import Foundation

/// Representa los datos relevantes extraídos localmente desde el JWT.
///
/// Este modelo contiene información de identidad y vigencia que la app
/// utiliza para reconstruir el estado de sesión del usuario.
struct LoginUserProfileModel: Equatable, Sendable {
    /// Identificación del contribuyente.
    let identificacion: String
    
    /// Razón social del contribuyente.
    let razonSocial: String
    
    /// Timestamp de expiración del token en milisegundos.
    let validoHasta: Int64
}
