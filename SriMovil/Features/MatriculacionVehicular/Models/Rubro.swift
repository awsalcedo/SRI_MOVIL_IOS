//
//  Rubro.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct Rubro: Hashable, Identifiable, Codable, Sendable {
    var id: String { descripcion }
    
    let descripcion: String
    let valor: Double
    let periodoFiscal: String
    let beneficiario: String
    let detallesRubro: [DetallesRubro]
}
