//
//  SwitchUserInteractor.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import Foundation

/// Implementación concreta del caso de uso de cambio de usuario.
///
/// Este interactor elimina la identidad y la autenticación persistidas,
/// dejando la aplicación en un estado equivalente al de un usuario
/// no identificado.
final class SwitchUserInteractor: SwitchUserInteractorProtocol {
    
    // MARK: - Private Properties
    
    private let sessionStore: SessionStoreProtocol
    
    // MARK: - Initializers
    
    /// Crea una nueva instancia del interactor de cambio de usuario.
    ///
    /// - Parameter sessionStore: Store responsable de la persistencia
    ///   segura de la sesión. Por defecto utiliza `KeychainSessionStore`.
    init(sessionStore: SessionStoreProtocol = KeychainSessionStore()) {
        self.sessionStore = sessionStore
    }
    
    // MARK: - Functions
    
    func switchUser() throws {
        try sessionStore.deleteAll()
    }
}
