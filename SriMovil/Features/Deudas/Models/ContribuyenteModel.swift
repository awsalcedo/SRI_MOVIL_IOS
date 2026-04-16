//
//  ContribuyenteModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 30/3/26.
//

import Foundation

struct ContribuyenteModel: Hashable, Sendable {
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
