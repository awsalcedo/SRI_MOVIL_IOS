//
//  TasaDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct TasaDto: Codable {
    let descripcion: String
    let deudas: [DeudaDto]
    let subtotal: Double
}

extension TasaDto {
    var toDomain: Tasa {
        Tasa(descripcion: descripcion, deudas: deudas.map{ $0.toDomain }, subtotal: subtotal)
    }
}
