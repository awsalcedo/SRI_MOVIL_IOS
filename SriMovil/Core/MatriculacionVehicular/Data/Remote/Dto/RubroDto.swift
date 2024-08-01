//
//  RubroDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct RubroDto: Codable {
    let descripcion: String
    let valor: Double
    let periodoFiscal: String
    let beneficiario: String
    let detallesRubro: [DetallesRubroDto]
}
