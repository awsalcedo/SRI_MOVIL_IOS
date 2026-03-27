//
//  DetallesRubroDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct DetallesRubroDto: Codable {
    let descripcion: String
    let anio: Int
    let valor: Double
}

extension DetallesRubroDto {
    var toDomain: DetallesRubro {
        DetallesRubro(descripcion: descripcion, anio: anio, valor: valor)
    }
}
