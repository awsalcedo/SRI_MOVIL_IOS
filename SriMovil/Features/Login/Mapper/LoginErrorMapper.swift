//
//  LoginErrorMapper.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import Foundation

/// Responsable de transformar errores técnicos o mensajes del backend
/// en errores de presentación específicos de la feature Login.
///
/// - Important:
/// Centraliza la lógica heredada del sistema legacy para evitar
/// dispersión de reglas en el ViewModel.
struct LoginErrorMapper {
    
    static func map(from error: Error) -> LoginPresentationError {
        
        if let networkError = error as? NetworkError {
            switch networkError {
            case .unauthorized:
                return .invalidCredentials
            case .serverError:
                return .unavailable
            default:
                return .unavailable
            }
        }
        
        // Aquí puedes agregar parsing si en el futuro capturas mensajes backend
        
        return .unavailable
    }
}
