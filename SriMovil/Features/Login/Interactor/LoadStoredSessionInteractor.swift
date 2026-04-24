//
//  LoadStoredSessionInteractor.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Implementación concreta del caso de uso encargado de reconstruir
/// la sesión persistida del usuario.
///
/// `LoadStoredSessionInteractor` consulta la identidad y autenticación
/// almacenadas localmente, valida si la sesión sigue vigente y devuelve
/// un modelo listo para consumo por la capa de presentación.
///
/// - Important:
/// Si existe autenticación persistida pero ya expiró, este interactor
/// elimina únicamente la autenticación y conserva la identidad conocida,
/// replicando la lógica funcional de la implementación legacy.
final class LoadStoredSessionInteractor: LoadStoredSessionInteractorProtocol, Sendable {
    
    // MARK: - Private Properties
    
    private let sessionStore: SessionStoreProtocol
    
    // MARK: - Initializers
    
    init(sessionStore: SessionStoreProtocol = KeychainSessionStore()) {
        self.sessionStore = sessionStore
    }
    
    // MARK: - Functions
    
    func loadStoredSession() throws -> LoginSessionSnapshot {
        let identity = try sessionStore.getIdentity()
        let authentication = try sessionStore.getAuthentication()
        
        let currentTimestamp = Int64(Date().timeIntervalSince1970 * 1000)
        
        if let identity,
           let authentication,
           authentication.validoHasta > currentTimestamp {
            return LoginSessionSnapshot(
                identificado: true,
                autenticado: true,
                identificacion: identity.identificacion,
                razonSocial: identity.razonSocial
            )
        }
        
        if let authentication,
           authentication.validoHasta <= currentTimestamp {
            try sessionStore.deleteAuthentication()
        }
        
        if let identity {
            return LoginSessionSnapshot(
                identificado: true,
                autenticado: false,
                identificacion: identity.identificacion,
                razonSocial: identity.razonSocial
            )
        }
        
        return LoginSessionSnapshot(
            identificado: false,
            autenticado: false,
            identificacion: nil,
            razonSocial: nil
        )
    }
}
