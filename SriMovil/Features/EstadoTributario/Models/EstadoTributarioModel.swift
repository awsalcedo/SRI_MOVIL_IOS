//
//  EstadoTributarioModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

enum EstadoContribuyente: Sendable, Hashable {
    case obligacionesPendientes
    case alDia
    case desconocido(String)
    
    var displayValue: String {
        switch self {
        case .obligacionesPendientes:
            return "OBLIGACIONES PENDIENTES"
        case .alDia:
            return "AL DIA EN SUS OBLIGACIONES"
        case .desconocido(let value):
            return value
        }
    }
}

struct EstadoTributarioModel: Hashable {
    //let id: UUID
    let ruc: String
    let razonSocial: String
    let descripcion: EstadoContribuyente
    let plazoVigenciaDoc: String
    let claseContribuyente: String
    let obligacionesPendientes: [ObligacionesPendientesModel]?
}
