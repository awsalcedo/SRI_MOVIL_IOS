//
//  DeudaDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct DeudaDto: Codable {
    let descripcion: String
    let rubros: [RubroDto]
    let subtotal: Double
}
