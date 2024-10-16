//
//  ObligacionesPendientesModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

struct ObligacionesPendientesModel: Codable, Hashable, Identifiable {
    let id: UUID = UUID()
    let descripcion: String
    let periodos: [String]
    
    
}
