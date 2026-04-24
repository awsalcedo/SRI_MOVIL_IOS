//
//  AuthenticatedSessionModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Representa el resultado de una autenticación remota exitosa.
///
/// Este modelo encapsula el token de acceso limpio retornado por el endpoint
/// de login y sirve como resultado inmediato del caso de uso de autenticación.
struct AuthenticatedSessionModel: Equatable, Sendable {
    
    /// Token de acceso limpio, sin prefijos del backend.
    let accessToken: String
}
