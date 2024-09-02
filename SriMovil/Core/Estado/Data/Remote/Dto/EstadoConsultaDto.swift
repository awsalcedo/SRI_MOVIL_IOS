//
//  ConsultaDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation

struct ConsultaDto: Codable {
    let idConsulta: String
    let habilitada: Bool
    let mensajeSecundario: String?
}
