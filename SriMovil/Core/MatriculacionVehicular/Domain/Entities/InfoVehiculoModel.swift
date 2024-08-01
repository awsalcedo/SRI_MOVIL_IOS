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

struct InfoVehiculoModel: Codable, Equatable, Hashable {
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
    
    init(from dto: InfoVehiculoDto) {
            self.fechaUltimaMatricula = dto.fechaUltimaMatricula
            self.fechaCaducidadMatricula = dto.fechaCaducidadMatricula
            self.cantonMatricula = dto.cantonMatricula
            self.fechaRevision = dto.fechaRevision
            self.total = dto.total
            self.informacion = dto.informacion
            self.estadoAuto = dto.estadoAuto
            self.mensajeMotivoAuto = dto.mensajeMotivoAuto
            self.placa = dto.placa
            self.camvCpn = dto.camvCpn
            self.cilindraje = dto.cilindraje
            self.fechaCompra = dto.fechaCompra
            self.anioUltimoPago = dto.anioUltimoPago
            self.marca = dto.marca
            self.modelo = dto.modelo
            self.anioModelo = dto.anioModelo
            self.paisFabricacion = dto.paisFabricacion
            self.clase = dto.clase
            self.servicio = dto.servicio
            self.tipoUso = dto.tipoUso
            self.deudas = dto.deudas?.map { Deuda(from: $0) }
            self.tasas = dto.tasas?.map { Tasa(from: $0) }
            self.remision = dto.remision
        }
    
    // Implementación automática de Equatable y Hashable usando Swift 4.1+
        static func == (lhs: InfoVehiculoModel, rhs: InfoVehiculoModel) -> Bool {
            return lhs.fechaUltimaMatricula == rhs.fechaUltimaMatricula &&
                lhs.fechaCaducidadMatricula == rhs.fechaCaducidadMatricula &&
                lhs.cantonMatricula == rhs.cantonMatricula &&
                lhs.fechaRevision == rhs.fechaRevision &&
                lhs.total == rhs.total &&
                lhs.informacion == rhs.informacion &&
                lhs.estadoAuto == rhs.estadoAuto &&
                lhs.mensajeMotivoAuto == rhs.mensajeMotivoAuto &&
                lhs.placa == rhs.placa &&
                lhs.camvCpn == rhs.camvCpn &&
                lhs.cilindraje == rhs.cilindraje &&
                lhs.fechaCompra == rhs.fechaCompra &&
                lhs.anioUltimoPago == rhs.anioUltimoPago &&
                lhs.marca == rhs.marca &&
                lhs.modelo == rhs.modelo &&
                lhs.anioModelo == rhs.anioModelo &&
                lhs.paisFabricacion == rhs.paisFabricacion &&
                lhs.clase == rhs.clase &&
                lhs.servicio == rhs.servicio &&
                lhs.tipoUso == rhs.tipoUso &&
                lhs.deudas == rhs.deudas &&
                lhs.tasas == rhs.tasas &&
                lhs.remision == rhs.remision
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(fechaUltimaMatricula)
            hasher.combine(fechaCaducidadMatricula)
            hasher.combine(cantonMatricula)
            hasher.combine(fechaRevision)
            hasher.combine(total)
            hasher.combine(informacion)
            hasher.combine(estadoAuto)
            hasher.combine(mensajeMotivoAuto)
            hasher.combine(placa)
            hasher.combine(camvCpn)
            hasher.combine(cilindraje)
            hasher.combine(fechaCompra)
            hasher.combine(anioUltimoPago)
            hasher.combine(marca)
            hasher.combine(modelo)
            hasher.combine(anioModelo)
            hasher.combine(paisFabricacion)
            hasher.combine(clase)
            hasher.combine(servicio)
            hasher.combine(tipoUso)
            hasher.combine(deudas)
            hasher.combine(tasas)
            hasher.combine(remision)
        }
}
