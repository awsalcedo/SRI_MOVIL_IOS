//
//  InfoVehiculoDto.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct InfoVehiculoDto: Codable {
    let fechaUltimaMatricula: Int
    let fechaCaducidadMatricula: Int
    let cantonMatricula: String
    let fechaRevision: Int
    let total: Double?
    let informacion: String?
    let estadoAuto: String
    let mensajeMotivoAuto: String?
    let placa: String
    let camvCpn: String
    let cilindraje: Double
    let fechaCompra: Int
    let anioUltimoPago: Int
    let marca: String
    let modelo: String
    let anioModelo: Int
    let paisFabricacion: String
    let clase: String
    let servicio: String
    let tipoUso: String
    let deudas: [DeudaDto]?
    let tasas: [TasaDto]?
    let remision: String?
}
