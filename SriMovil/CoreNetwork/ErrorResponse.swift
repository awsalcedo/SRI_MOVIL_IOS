//
//  ErrorResponse.swift
//  SriMovil
//
//  Created by usradmin on 14/10/24.
//

import Foundation

struct ErrorResponse: Codable {
    let codigo: String
    let mensaje: String
    let detalles: String?
}
