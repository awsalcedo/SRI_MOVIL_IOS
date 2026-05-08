//
//  AnalyticsTracking.swift
//  SriMovil
//
//  Created by usradmin on 8/5/26.
//

import Foundation

/// Abstracción para el registro de eventos analíticos dentro de la aplicación.
///
/// `AnalyticsTracking` define un contrato desacoplado para el envío de eventos
/// de analítica, permitiendo que las capas superiores de la aplicación
/// (por ejemplo ViewModels o casos de uso) no dependan directamente de una
/// implementación específica como Firebase Analytics.
///
/// Esta abstracción facilita:
/// - desacoplar la lógica de negocio de proveedores externos,
/// - reemplazar fácilmente la plataforma de analítica en el futuro,
/// - simplificar pruebas unitarias mediante mocks o spies,
/// - centralizar y estandarizar el envío de eventos.
///
/// Las implementaciones concretas pueden utilizar herramientas como:
/// - Firebase Analytics,
/// - Mixpanel,
/// - Datadog,
/// - Amplitude,
/// - u otras plataformas de observabilidad y métricas.
///
/// Ejemplo de uso:
///
/// ```swift
/// analytics.track(
///     event: "matriculacion_vehicular_exito",
///     parameters: [
///         "placa": "ABC1234"
///     ]
/// )
/// ```
protocol AnalyticsTracking {
    
    /// Registra un evento analítico.
    ///
    /// - Parameters:
    ///   - event: Nombre único del evento analítico.
    ///   Se recomienda utilizar nombres en formato `snake_case`
    ///   y mantener una nomenclatura consistente en toda la aplicación.
    ///
    ///   - parameters: Diccionario opcional de parámetros asociados al evento.
    ///   Puede incluir información contextual relevante como identificadores,
    ///   estados, tipos de operación o metadatos funcionales.
    func track(
        event: String,
        parameters: [String: Any]?
    )
}
