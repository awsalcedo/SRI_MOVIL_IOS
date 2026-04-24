//
//  KeychainConstants.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Define las constantes utilizadas para identificar elementos persistidos
/// en el keychain de la aplicación.
///
/// Este namespace centraliza nombres de servicio y cuentas (`account`)
/// para evitar valores duplicados o hardcodes dispersos en el código.
///
/// - Important:
/// Cualquier cambio en estos valores impacta directamente la lectura
/// de datos previamente almacenados en keychain.
enum KeychainConstants {
    
    /// Nombre de servicio bajo el cual la app almacena información de sesión.
    static let service = "ec.gob.sri.movil.session"
    
    /// Clave utilizada para persistir la identidad conocida del contribuyente.
    static let identityAccount = "auth.identity"
    
    /// Clave utilizada para persistir la autenticación activa del usuario.
    static let authenticationAccount = "auth.authentication"
}
