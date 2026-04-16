//
//  DeudasModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 30/3/26.
//

import Foundation

struct DeudasModel: Hashable, Sendable {
    let contribuyente: ContribuyenteModel
    let deuda: DeudaModel?
    let impugnacion: String?
    let remision: String?
}
