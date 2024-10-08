//
//  EstadoTributarioDTO.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

struct EstadoTributarioDTO: Codable, Identifiable, Hashable {
    let id: UUID
    let ruc: String
    let razonSocial: String
    let descripcion: String
    let plazoVigenciaDoc: String
    let claseContribuyente: String
    let obligacionesPendientes: [ObligacionesPendientesDTO]?
}

extension EstadoTributarioDTO {
    var toDomain: EstadoTributarioModel {
        EstadoTributarioModel(id: id,
                              ruc: ruc, razonSocial: razonSocial, descripcion: descripcion, plazoVigenciaDoc: plazoVigenciaDoc, claseContribuyente: claseContribuyente, obligacionesPendientes: obligacionesPendientes?.map { $0.toDomain })
    }
}

