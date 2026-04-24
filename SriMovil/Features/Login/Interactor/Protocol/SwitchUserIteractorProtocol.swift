//
//  SwitchUserInteractorProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import Foundation

/// Define el contrato del caso de uso para cambiar de usuario.
///
/// Este flujo elimina completamente la información persistida de sesión,
/// incluyendo identidad y autenticación.
protocol SwitchUserInteractorProtocol: Sendable {
    
    /// Elimina toda la información persistida del usuario actual.
    ///
    /// - Throws:
    ///   - Errores provenientes del store de sesión.
    func switchUser() throws
}
