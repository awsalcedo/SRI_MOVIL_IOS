//
//  ConsultaRoute.swift
//  SriMovil
//
//  Created by usradmin on 5/6/26.
//

import Foundation

enum ConsultaRoute: String, Identifiable, Sendable {
    case comprobantesElectronicos
    case estadoTributario
    case valoresPagar
    case deudas
    case validezComprobantes
    case impuestoRenta
    case certificados
    case seguimientoTramites
    case validacionQR
    case citaPrevia
    case calculadoras
    case denuncias
    case contactenos
    case simar
    case facturadorSRI
    case configuracion
    case politicaDatos
    
    var id: String { rawValue }
}
