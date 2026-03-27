//
//  AuthenticationType.swift
//  SriMovil
//
//  Created by usradmin on 14/11/24.
//

import Foundation

enum AuthenticationType {
    case none
    case token(String)
    case credentials(username: String, password: String)
}
