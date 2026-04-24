//
//  LoadStoredSessionInteractorProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Define el contrato del caso de uso encargado de reconstruir
/// la sesión persistida localmente.
///
/// Este interactor permite que la feature de login consulte el estado
/// actual de identidad y autenticación almacenado en el dispositivo,
/// replicando el comportamiento histórico de la aplicación al abrir
/// la pantalla de login.
///
/// Beneficios:
/// - desacopla la capa de presentación de la persistencia local,
/// - facilita pruebas unitarias mediante mocks,
/// - centraliza la lógica de validación de sesión vigente.
protocol LoadStoredSessionInteractorProtocol: Sendable {
    
    /// Carga la sesión persistida y determina el estado actual del usuario.
    ///
    /// - Returns: Un snapshot con el estado reconstruido de la sesión.
    ///
    /// - Throws:
    ///   - Errores de persistencia provenientes del store de sesión.
    func loadStoredSession() throws -> LoginSessionSnapshot
}
