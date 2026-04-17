//
//  CategoriServicio.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import Foundation

enum CategoriaServicio: String, Codable, CaseIterable, Identifiable, Hashable {
    case vehiculos
    case tributario
    case documentos
    case tramites
    case herramientas
    case soporte
    
    var id: String { rawValue }
    
    var titulo: String {
        switch self {
        case .vehiculos:
            return "Vehículos"
        case .tributario:
            return "Información tributaria"
        case .documentos:
            return "Documentos y certificados"
        case .tramites:
            return "Trámites y validaciones"
        case .herramientas:
            return "Herramientas"
        case .soporte:
            return "Soporte"
        }
    }
}
