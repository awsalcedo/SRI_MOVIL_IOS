//
//  Deuda.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct Deuda: Codable, Identifiable, Hashable, Sendable {
    var id = UUID()
    let descripcion: String
    let rubros: [Rubro]
    let subtotal: Double
}
