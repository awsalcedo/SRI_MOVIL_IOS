//
//  EstadoDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation

struct EstadoDto: Codable {
    let mensajeGeneral: String?
    let mensajeDestacado: Bool
    var fechaEstado: Int
    var fechaInfoAgencias: Int
    var fechaBanner: Int
    let habilitado: Bool
    let estadoConsultas: [EstadoConsultaDto]
    let estado: [EstadoInternoDto]
}

