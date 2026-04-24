//
//  LogoutInteractorProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Define el contrato del caso de uso para cerrar sesión.
///
/// Este flujo elimina solo la autenticación activa y conserva
/// la identidad conocida del contribuyente.
protocol LogoutInteractorProtocol: Sendable {
    
    /// Cierra la sesión actual del usuario.
    ///
    /// - Throws:
    ///   - Errores provenientes del store de sesión.
    func logout() throws
}
