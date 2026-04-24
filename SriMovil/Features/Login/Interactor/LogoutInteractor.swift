//
//  LogoutInteractor.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import Foundation

/// Implementación concreta del caso de uso de cierre de sesión.
///
/// Este interactor elimina únicamente la autenticación persistida,
/// manteniendo la identidad conocida del usuario para permitir
/// un nuevo ingreso sin volver a capturar la identificación.
final class LogoutInteractor: LogoutInteractorProtocol {
    
    // MARK: - Private Properties
    
    private let sessionStore: SessionStoreProtocol
    
    // MARK: - Initializers
    
    /// Crea una nueva instancia del interactor de cierre de sesión.
    ///
    /// - Parameter sessionStore: Store responsable de la persistencia
    ///   segura de la sesión. Por defecto utiliza `KeychainSessionStore`.
    init(sessionStore: SessionStoreProtocol = KeychainSessionStore()) {
        self.sessionStore = sessionStore
    }
    
    // MARK: - Functions
    
    func logout() throws {
        try sessionStore.deleteAuthentication()
    }
}
