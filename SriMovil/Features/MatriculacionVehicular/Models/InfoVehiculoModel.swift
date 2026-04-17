//
//  InfoVehiculoModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

/*
 Se usa el protocolo Codable para facilitar la codificación y decodificación de JSON
 */

struct InfoVehiculoModel: Codable, Equatable, Hashable, Sendable {
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
    let deudas: [Deuda]?
    let tasas: [Tasa]?
    let remision: String?
}
