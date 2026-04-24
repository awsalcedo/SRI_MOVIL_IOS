//
//  KeychainError.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Define errores producidos por operaciones sobre Keychain.
enum KeychainError: LocalizedError, Equatable {
    case encodingFailed
    case decodingFailed
    case saveFailed(OSStatus)
    case updateFailed(OSStatus)
    case retrievalFailed(OSStatus)
    case deleteFailed(OSStatus)
    
    var errorDescription: String? {
        switch self {
        case .encodingFailed:
            return "No fue posible codificar la información de sesión."
        case .decodingFailed:
            return "No fue posible decodificar la información de sesión."
        case .saveFailed(let status):
            return "No fue posible guardar en Keychain. Código: \(status)"
        case .updateFailed(let status):
            return "No fue posible actualizar Keychain. Código: \(status)"
        case .retrievalFailed(let status):
            return "No fue posible recuperar datos desde Keychain. Código: \(status)"
        case .deleteFailed(let status):
            return "No fue posible eliminar datos desde Keychain. Código: \(status)"
        }
    }
}
