//
//  CategoriServicio.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import Foundation

/// Representa las categorías disponibles para agrupar los servicios de consulta.
///
/// Este enum define la organización lógica de los servicios dentro de la app,
/// permitiendo:
/// - Agrupar contenido para mejorar la escaneabilidad (HIG).
/// - Filtrar servicios por categoría en el ViewModel.
/// - Mantener consistencia entre dominio, UI y backend.
///
/// ## Consideraciones
/// - Los `case` representan valores de dominio (NO UI).
/// - Las etiquetas visibles se definen en `titulo`.
/// - Mantener nombres estables para evitar romper lógica existente.
///
enum CategoriaServicio: String, Codable, CaseIterable, Identifiable, Hashable {
    
    // MARK: - Cases (Dominio)
    
    case vehiculos
    case tributario
    case documentos
    case tramites
    case herramientas
    case soporte
    
    // MARK: - Identifiable
    
    var id: String { rawValue }
    
    // MARK: - UI
    
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
    
    // MARK: - Orden (muy importante a nivel UX)
    
    /// Orden explícito para presentación en UI.
    ///
    /// Evita depender del orden de `allCases`,
    /// permitiendo control total sobre la experiencia del usuario.
    static var ordered: [CategoriaServicio] {
        [
            .vehiculos,
            .tributario,
            .documentos,
            .tramites,
            .herramientas,
            .soporte
        ]
    }
}
