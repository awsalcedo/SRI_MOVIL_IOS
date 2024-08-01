//
//  Tasa.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct Tasa: Codable, Equatable, Hashable {
    let descripcion: String
    let deudas: [Deuda]
    let subtotal: Double
    
    init(from dto: TasaDto) {
        self.descripcion = dto.descripcion
        self.deudas = dto.deudas.map { Deuda(from: $0) }
        self.subtotal = dto.subtotal
    }
    
    static func == (lhs: Tasa, rhs: Tasa) -> Bool {
            return lhs.descripcion == rhs.descripcion &&
                lhs.deudas == rhs.deudas &&
                lhs.subtotal == rhs.subtotal
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(descripcion)
            hasher.combine(deudas)
            hasher.combine(subtotal)
        }
}
