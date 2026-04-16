//
//  DetalleRubroDTO.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 30/3/26.
//

import Foundation

struct DetalleRubroDTO: Codable, Hashable, Sendable {
    let descripcion: String
    let anio: Int
    let valor: Double
}

extension DetalleRubroDTO {
    func toDomain() -> DetalleRubroModel {
        DetalleRubroModel(descripcion: descripcion, anio: anio, valor: valor)
    }
}
