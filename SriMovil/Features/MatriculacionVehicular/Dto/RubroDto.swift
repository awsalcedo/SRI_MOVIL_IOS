//
//  RubroDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct RubroDto: Codable, Sendable {
    let descripcion: String
    let valor: Double
    let periodoFiscal: String
    let beneficiario: String
    let detallesRubro: [DetallesRubroDto]
}

extension RubroDto {
    func toDomain() -> Rubro {
        Rubro(
            descripcion: descripcion,
            valor: valor,
            periodoFiscal: periodoFiscal,
            beneficiario: beneficiario,
            detallesRubro: detallesRubro.map { $0.toDomain() }
        )
    }
}
