//
//  SessionStoreProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Define el contrato para persistir y recuperar información de sesión.
///
/// Este protocolo abstrae el mecanismo de almacenamiento seguro utilizado
/// por la app para conservar identidad y autenticación del usuario.
///
/// Beneficios:
/// - desacopla la feature de login de una implementación concreta de Keychain,
/// - facilita pruebas unitarias mediante mocks,
/// - permite evolucionar la estrategia de persistencia sin afectar las capas superiores.
protocol SessionStoreProtocol: Sendable {
    
    /// Persiste la identidad conocida del usuario.
    ///
    /// - Parameter identity: Identidad a almacenar.
    func saveIdentity(_ identity: StoredIdentity) throws
    
    /// Recupera la identidad previamente almacenada.
    ///
    /// - Returns: La identidad persistida, o `nil` si no existe.
    func getIdentity() throws -> StoredIdentity?
    
    /// Elimina la identidad almacenada.
    func deleteIdentity() throws
    
    /// Persiste la autenticación activa del usuario.
    ///
    /// - Parameter authentication: Autenticación a almacenar.
    func saveAuthentication(_ authentication: StoredAuthentication) throws
    
    /// Recupera la autenticación previamente almacenada.
    ///
    /// - Returns: La autenticación persistida, o `nil` si no existe.
    func getAuthentication() throws -> StoredAuthentication?
    
    /// Elimina la autenticación almacenada.
    func deleteAuthentication() throws
    
    /// Elimina toda la información de sesión persistida.
    func deleteAll() throws
}
