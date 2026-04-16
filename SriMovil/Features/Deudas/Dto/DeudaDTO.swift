//
//  DeudaDTO.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 30/3/26.
//

import Foundation

struct DeudaDTO: Codable, Hashable, Sendable {
    let descripcion: String
    let valor: Double
    let periodoFiscal: String?
    let beneficiario: String?
    let detallesRubro: [DetalleRubroDTO]?
}

extension DeudaDTO {
    func toDomain() -> DeudaModel {
        DeudaModel(descripcion: descripcion, valor: valor, periodoFiscal: periodoFiscal, beneficiario: beneficiario, detallesRubro: detallesRubro?.map {
            $0.toDomain()}
        )
    }
}
