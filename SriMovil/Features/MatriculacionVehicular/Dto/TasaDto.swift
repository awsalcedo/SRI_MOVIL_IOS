//
//  TasaDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct TasaDto: Codable, Sendable {
    let descripcion: String
    let deudas: [DeudaDto]
    let subtotal: Double
}

extension TasaDto {
    func toDomain() -> Tasa {
        Tasa(
            descripcion: descripcion,
            deudas: deudas.map{ $0.toDomain() },
            subtotal: subtotal
        )
    }
}
