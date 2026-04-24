//
//  LoginPresentationError.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Define errores de presentación de la feature de login.
enum LoginPresentationError: LocalizedError, Equatable {
    case emptyIdentificacion
    case emptyPassword
    case invalidCredentials
    case blockedPassword
    case inactivePassword
    case expiredPassword
    case unavailable
    case generic(String)
    
    var errorDescription: String? {
        switch self {
        case .emptyIdentificacion:
            return "Ingresa tu RUC, cédula o pasaporte."
        case .emptyPassword:
            return "Ingresa tu clave."
        case .invalidCredentials:
            return "La identificación y/o clave no son correctas."
        case .blockedPassword:
            return "Clave bloqueada. Accede a la opción para recuperar clave."
        case .inactivePassword:
            return "Clave inactiva."
        case .expiredPassword:
            return "Tu clave debe actualizarse."
        case .unavailable:
            return "No se puede realizar la autenticación en este momento."
        case .generic(let message):
            return message
        }
    }
}
