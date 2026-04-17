//
//  DeudaDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct DeudaDto: Codable, Sendable {
    let descripcion: String
    let rubros: [RubroDto]
    let subtotal: Double
}

extension DeudaDto {
    func toDomain() -> Deuda {
        Deuda(
            descripcion: descripcion,
            rubros: rubros.map { $0.toDomain() },
            subtotal: subtotal
        )
    }
}
