//
//  DeudaModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 30/3/26.
//

import Foundation

struct DeudaModel: Hashable, Sendable {
    let descripcion: String
    let valor: Double
    let periodoFiscal: String?
    let beneficiario: String?
    let detallesRubro: [DetalleRubroModel]?
}
