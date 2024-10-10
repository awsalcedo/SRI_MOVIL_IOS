//
//  EstadoTributarioModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

struct EstadoTributarioModel: Codable, Hashable {
    //let id: UUID
    let ruc: String
    let razonSocial: String
    let descripcion: String
    let plazoVigenciaDoc: String
    let claseContribuyente: String
    let obligacionesPendientes: [ObligacionesPendientesModel]?
}
