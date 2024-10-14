//
//  DetallesRubro.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct DetallesRubro: Identifiable, Hashable, Codable {
    var id = UUID()
    let descripcion: String
    let anio: Int
    let valor: Double
    
    /*init(from dto: DetallesRubroDto) {
            self.descripcion = dto.descripcion
            self.anio = dto.anio
            self.valor = dto.valor
        }*/
}
