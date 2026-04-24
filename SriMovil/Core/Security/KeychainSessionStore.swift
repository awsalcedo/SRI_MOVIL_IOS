//
//  KeychainSessionStore.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Implementación basada en Keychain para persistir datos de sesión.
///
/// Este store encapsula el acceso a Keychain Services para almacenar
/// de manera segura la identidad conocida y la autenticación activa
/// del usuario.
///
/// - Important:
/// Los datos de autenticación no deben persistirse en `UserDefaults`
/// ni en `SwiftData`, ya que contienen información sensible.
final class KeychainSessionStore: SessionStoreProtocol, Sendable {
    
    // MARK: - Propiedades Privadas
    
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    // MARK: - Inicializador
    
    /// Crea una nueva instancia del store de sesión basado en Keychain.
    ///
    /// - Parameters:
    ///   - encoder: Encoder usado para serializar modelos persistidos.
    ///   - decoder: Decoder usado para reconstruir modelos persistidos.
    init(encoder: JSONEncoder = JSONEncoder(),
         decoder: JSONDecoder = JSONDecoder()
    ) {
        self.encoder = encoder
        self.decoder = decoder
    }
    
    // MARK: - Funciones
    
    func saveIdentity(_ identity: StoredIdentity) throws {
        let data = try encode(identity)
        try save(data: data, account: KeychainConstants.identityAccount)
    }
    
    func getIdentity() throws -> StoredIdentity? {
        guard let data = try getData(account: KeychainConstants.identityAccount) else {
            return nil
        }
        return try decode(StoredIdentity.self, from: data)
    }
    
    func deleteIdentity() throws {
        try delete(account: KeychainConstants.identityAccount)
    }
    
    func saveAuthentication(_ authentication: StoredAuthentication) throws {
        let data = try encode(authentication)
        try save(data: data, account: KeychainConstants.authenticationAccount)
    }
    
    func getAuthentication() throws -> StoredAuthentication? {
        guard let data = try getData(account: KeychainConstants.authenticationAccount) else {
            return nil
        }
        return try decode(StoredAuthentication.self, from: data)
    }
    
    func deleteAuthentication() throws {
        try delete(account: KeychainConstants.authenticationAccount)
    }
    
    func deleteAll() throws {
        try deleteIdentity()
        try deleteAuthentication()
    }
    
    // MARK: - Funciones Privadas
    
    /// Codifica un modelo para persistirlo en Keychain.
    private func encode<Value: Encodable>(_ value: Value) throws -> Data {
        do {
            return try encoder.encode(value)
        } catch {
            throw KeychainError.encodingFailed
        }
    }
    
    /// Decodifica un modelo recuperado desde Keychain.
    private func decode<Value: Decodable>(_ type: Value.Type, from data: Data) throws -> Value {
        do {
            return try decoder.decode(type, from: data)
        } catch {
            throw KeychainError.decodingFailed
        }
    }
    
    /// Guarda o actualiza un ítem dentro de Keychain.
    private func save(data: Data, account: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: KeychainConstants.service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            let updateQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: KeychainConstants.service,
                kSecAttrAccount as String: account
            ]
            
            let updatedAttributes: [String: Any] = [
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
            ]
            
            let updateStatus = SecItemUpdate(
                updateQuery as CFDictionary,
                updatedAttributes as CFDictionary
            )
            
            guard updateStatus == errSecSuccess else {
                throw KeychainError.updateFailed(updateStatus)
            }
            
            return
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.saveFailed(status)
        }
    }
    
    /// Recupera los datos binarios asociados a una cuenta del Keychain.
    private func getData(account: String) throws -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: KeychainConstants.service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecItemNotFound {
            return nil
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.retrievalFailed(status)
        }
        
        return result as? Data
    }
    
    /// Elimina un ítem previamente almacenado en Keychain.
    private func delete(account: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: KeychainConstants.service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.deleteFailed(status)
        }
    }
}
