//
//  SRIErrorResponseDTO.swift
//  SriMovil
//
//  Created by usradmin on 27/3/26.
//

import Foundation

struct SRIErrorResponseDTO: Decodable, Sendable {
    let codigo: String
    let mensaje: String
    let detalles: String?
}
