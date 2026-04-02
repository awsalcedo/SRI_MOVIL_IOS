//
//  DeudasModel.swift
//  SriMovil
//
//  Created by usradmin on 30/3/26.
//

import Foundation

struct DeudasModel: Hashable {
    let contribuyente: ContribuyenteModel
    let deuda: DeudaModel?
    let impugnacion: String?
    let remision: String?
}
