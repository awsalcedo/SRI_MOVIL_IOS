//
//  FirebaseAnalyticsManager.swift
//  SriMovil
//
//  Created by usradmin on 8/5/26.
//

import FirebaseAnalytics

/// Implementación concreta de `AnalyticsTracking` utilizando Firebase Analytics.
///
/// `FirebaseAnalyticsManager` actúa como adaptador entre la aplicación
/// y el SDK de Firebase, encapsulando el acceso directo a `Analytics.logEvent`.
///
/// Esta implementación permite mantener desacopladas las capas superiores
/// de la aplicación (ViewModels, casos de uso y vistas) respecto al proveedor
/// de analítica utilizado.
///
/// ## Consideraciones de arquitectura
///
/// La aplicación adopta un enfoque desacoplado para el registro de eventos
/// analíticos, siguiendo prácticas comunes en aplicaciones iOS de mediana
/// y gran escala:
///
/// - Firebase se abstrae detrás del protocolo `AnalyticsTracking`.
/// - Los ViewModels no dependen directamente del SDK de Firebase.
/// - Los eventos se definen mediante nombres tipados y organizados por feature,
///   evitando estructuras monolíticas difíciles de mantener.
/// - La abstracción facilita la creación de mocks y pruebas unitarias.
/// - El proveedor de analítica puede reemplazarse en el futuro sin afectar
///   la lógica de negocio.
///
/// Este enfoque permite mantener una arquitectura flexible, testeable
/// y escalable sin introducir sobreingeniería innecesaria.
///
/// ## Ejemplo
///
/// ```swift
/// analytics.track(
///     event: "matriculacion_vehicular_exito",
///     parameters: [
///         "placa": "ABC1234"
///     ]
/// )
/// ```
final class FirebaseAnalyticsManager: AnalyticsTracking {
    
    /// Registra un evento en Firebase Analytics.
    ///
    /// - Parameters:
    ///   - event: Nombre único del evento analítico.
    ///   - parameters: Parámetros opcionales asociados al evento.
    ///
    /// Los eventos enviados mediante este método serán procesados
    /// y visualizados desde Firebase Console y Google Analytics.
    func track(
        event: String,
        parameters: [String : Any]? = nil
    ) {
        Analytics.logEvent(event, parameters: parameters)
    }
}

