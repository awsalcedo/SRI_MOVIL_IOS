//
//  ContribuyenteDTO.swift
//  SriMovil
//
//  Created by usradmin on 30/3/26.
//

import Foundation

struct ContribuyenteDTO: Codable, Hashable {
    let identificacion: String
    let denominacion: String?
    let tipo: String?
    let clase: String?
    let tipoIdentificacion: String
    let resolucion: String?
    let nombreComercial: String
    let direccionMatriz: String?
    let fechaInformacion: Date?
    let mensaje: String?
    let estado: String?
}

extension ContribuyenteDTO {
    func toDomain() -> ContribuyenteModel {
        ContribuyenteModel(identificacion: identificacion,
                           denominacion: denominacion,
                           tipo: tipo,
                           clase: clase,
                           tipoIdentificacion: tipoIdentificacion,
                           resolucion: resolucion,
                           nombreComercial: nombreComercial,
                           direccionMatriz: direccionMatriz,
                           fechaInformacion: fechaInformacion,
                           mensaje: mensaje,
                           estado: estado
        )
    }
}
