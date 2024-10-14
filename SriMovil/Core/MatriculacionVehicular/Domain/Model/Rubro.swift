//
//  Rubro.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct Rubro: Hashable, Identifiable, Codable {
    var id = UUID()
    let descripcion: String
    let valor: Double
    let periodoFiscal: String
    let beneficiario: String
    let detallesRubro: [DetallesRubro]
    
    init(from dto: RubroDto) {
            self.descripcion = dto.descripcion
            self.valor = dto.valor
            self.periodoFiscal = dto.periodoFiscal
            self.beneficiario = dto.beneficiario
            self.detallesRubro = dto.detallesRubro.map { DetallesRubro(from: $0) }
        }
    
    // Implementación de Equatable
        static func ==(lhs: Rubro, rhs: Rubro) -> Bool {
            return lhs.id == rhs.id &&
                lhs.descripcion == rhs.descripcion &&
                lhs.valor == rhs.valor &&
                lhs.periodoFiscal == rhs.periodoFiscal &&
                lhs.beneficiario == rhs.beneficiario &&
                lhs.detallesRubro == rhs.detallesRubro
        }
        
        // Implementación de Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(descripcion)
            hasher.combine(valor)
            hasher.combine(periodoFiscal)
            hasher.combine(beneficiario)
            hasher.combine(detallesRubro)
        }
}
