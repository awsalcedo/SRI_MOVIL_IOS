//
//  AnalyticsEvents.swift
//  SriMovil
//
//  Created by usradmin on 8/5/26.
//

import Foundation

/// Contenedor centralizado de nombres de eventos analíticos utilizados
/// dentro de la aplicación.
///
/// `AnalyticsEvents` organiza los eventos por feature o módulo funcional,
/// permitiendo mantener una nomenclatura consistente, escalable y fácil
/// de mantener a medida que la aplicación evoluciona.
///
/// ## Objetivos
///
/// - Evitar el uso de strings hardcodeados distribuidos en la aplicación.
/// - Reducir errores tipográficos en nombres de eventos.
/// - Centralizar la definición de eventos analíticos.
/// - Facilitar refactors y mantenimiento.
/// - Mantener independencia respecto al proveedor de analítica.
///
/// ## Estrategia de organización
///
/// Los eventos se agrupan mediante enums anidados por feature,
/// evitando estructuras monolíticas difíciles de escalar.
///
/// Cada módulo funcional define únicamente sus propios eventos,
/// permitiendo que nuevas funcionalidades agreguen métricas
/// sin afectar otras áreas de la aplicación.
///
/// ## Convención de nombres
///
/// Los nombres de eventos siguen el formato:
///
/// ```text
/// snake_case
/// ```
///
/// Recomendaciones:
///
/// - utilizar nombres descriptivos,
/// - evitar mayúsculas,
/// - evitar caracteres especiales,
/// - mantener consistencia entre features.
///
/// ## Ejemplo
///
/// ```swift
/// analytics.track(
///     event: AnalyticsEvents.MatriculacionEvent.exito,
///     parameters: [
///         "placa": "ABC1234"
///     ]
/// )
/// ```
enum AnalyticsEvents {
    
    /// Eventos analíticos relacionados con la funcionalidad
    /// de Matriculación Vehicular.
    enum MatriculacionEvent {
        static let exito = "matriculacion_vehicular_exito"
        static let error = "matriculacion_vehicular_error"
    }
    
    /// Eventos analíticos relacionados con la funcionalidad
    /// de Estado Tributario.
    enum EstadoTributarioEvent {
        static let exito = "estado_tributario_exito"
        static let error = "estado_tributario_error"
    }
}
