//
//  DetallesRubroDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct DetallesRubroDto: Codable, Sendable {
    let descripcion: String
    let anio: Int
    let valor: Double
}

extension DetallesRubroDto {
    func toDomain() -> DetallesRubro {
        DetallesRubro(
            descripcion: descripcion,
            anio: anio,
            valor: valor
        )
    }
}
