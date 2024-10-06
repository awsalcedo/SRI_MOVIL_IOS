//
//  AuthorizationMethod.swift
//  SriMovil
//
//  Created by usradmin on 1/10/24.
//

import Foundation


/// Enumeración que representa los principales métodos de autorización utilizados en las cabeceras HTTP de las solicitudes web.
public enum AuthorizationMethod: String {
    
    /// Método de autorización que utiliza un token, comúnmente asociado con la autenticación JWT (JSON Web Token).
    case token = "Bearer"
    
    /// Método de autorización que utiliza credenciales codificadas en base64, típicamente "username:password".
    case basic = "Basic"
}
