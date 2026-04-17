//
//  DetallesRubro.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct DetallesRubro: Identifiable, Hashable, Codable, Sendable {
    let id = UUID()
    let descripcion: String
    let anio: Int
    let valor: Double
}
