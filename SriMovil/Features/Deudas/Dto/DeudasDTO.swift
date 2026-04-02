//
//  DeudaDto.swift
//  SriMovil
//
//  Created by usradmin on 30/3/26.
//

import Foundation

struct DeudasDTO: Codable, Hashable {
    let contribuyente: ContribuyenteDTO
    let deuda: DeudaDTO?
    let impugnacion: String?
    let remision: String?
}

extension DeudasDTO {
    func toDomain() -> DeudasModel {
        DeudasModel(
            contribuyente: contribuyente.toDomain(),
            deuda: deuda?.toDomain(),
            impugnacion: impugnacion,
            remision: remision
        )
    }
}
