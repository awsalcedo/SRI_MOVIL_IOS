//
//  Tasa.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct Tasa: Codable, Equatable, Hashable, Sendable {
    let descripcion: String
    let deudas: [Deuda]
    let subtotal: Double
}
