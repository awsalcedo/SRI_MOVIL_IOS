//
//  ObligacionesPendientesDTO.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

struct ObligacionesPendientesDTO: Codable, Identifiable, Hashable {
    let id: UUID
    let descripcion: String
    let periodos: [String]
}

extension ObligacionesPendientesDTO {
    var toDomain: ObligacionesPendientesModel {
        ObligacionesPendientesModel(
            id: id,
            descripcion: descripcion,
            periodos: periodos
        )
    }
}
