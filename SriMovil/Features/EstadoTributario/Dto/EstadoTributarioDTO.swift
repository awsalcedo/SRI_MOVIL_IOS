//
//  EstadoTributarioDTO.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

struct EstadoTributarioDTO: Codable, Hashable, Sendable {
    let ruc: String
    let razonSocial: String
    let descripcion: String
    let plazoVigenciaDoc: String
    let claseContribuyente: String
    let obligacionesPendientes: [ObligacionesPendientesDTO]?
}

extension EstadoTributarioDTO {
    func toDomain() -> EstadoTributarioModel {
        EstadoTributarioModel(
            ruc: ruc,
            razonSocial: razonSocial,
            descripcion: mapEstado(from: descripcion),
            plazoVigenciaDoc: plazoVigenciaDoc,
            claseContribuyente: claseContribuyente,
            obligacionesPendientes: obligacionesPendientes?.map { $0.toDomain() })
    }
    
    private func mapEstado(from value: String) -> EstadoContribuyente {
        switch value.uppercased() {
        case "OBLIGACIONES PENDIENTES":
            return .obligacionesPendientes
        case "AL DIA EN SUS OBLIGACIONES":
            return .alDia
        default:
            return .desconocido(value)
        }
    }
}

