//
//  Deuda.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct Deuda: Codable, Identifiable, Hashable {
    var id = UUID()
    let descripcion: String
    let rubros: [Rubro]
    let subtotal: Double
    
    /*init(from dto: DeudaDto) {
            self.descripcion = dto.descripcion
            self.rubros = dto.rubros.map { Rubro(from: $0) }
            self.subtotal = dto.subtotal
        }
    
    static func == (lhs: Deuda, rhs: Deuda) -> Bool {
            return lhs.id == rhs.id &&
                lhs.descripcion == rhs.descripcion &&
                lhs.rubros == rhs.rubros &&
                lhs.subtotal == rhs.subtotal
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(descripcion)
            hasher.combine(rubros)
            hasher.combine(subtotal)
        }*/
}
