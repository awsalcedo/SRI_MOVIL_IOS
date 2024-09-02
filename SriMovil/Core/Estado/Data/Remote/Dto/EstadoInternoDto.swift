//
//  EstadoInternoDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation

struct EstadoInternoDto: Codable {
    let idConsulta: String
    let habilitada: Bool
    let mensajeSecundario: String?
}
