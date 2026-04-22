//
//  API.swift
//  SriMovil
//
//  Created by awss010915 on 25/3/26.
//

import Foundation

/// Namespace principal para la configuración de la API.
///
/// Contiene la URL base del backend del SRI y sirve como punto central
/// para la construcción de endpoints dentro de la aplicación.
///
/// - Important: Toda URL debe construirse a partir de `baseURL` para
/// garantizar consistencia y evitar hardcodes dispersos en el código.
enum API {
    
    /// URL base del backend del SRI.
    ///
    /// Ejemplo:
    /// `https://srienlinea.sri.gob.ec/`
    ///
    /// - Note: Se define como `URL` en lugar de `String` para asegurar
    /// validación temprana y evitar errores en tiempo de ejecución.
    static let baseURL = URL(string: "https://srienlinea.sri.gob.ec/")!
}

/// Extensión de `URL` que centraliza la construcción de endpoints de la API.
///
/// Este enfoque permite:
/// - Evitar concatenación manual de strings.
/// - Manejar correctamente encoding de parámetros.
/// - Mantener consistencia en la construcción de URLs.
/// - Mejorar la mantenibilidad y escalabilidad del código.
///
/// - Important: Todos los endpoints deben definirse aquí para mantener
/// una única fuente de verdad.
extension URL {
    
    // MARK: - Matriculacion Vehicular
    
    static func matriculacionVehicular(idVehiculo: String) -> URL {
        API.baseURL.appending(path: "movil-servicios/api/v1.0/matriculacion/valor/\(idVehiculo)")
    }
    
    // MARK: - Estado Tributario
    
    static func estadoTributario(ruc: String) -> URL {
        API.baseURL.appending(path: "movil-servicios/api/v1.0/estadoTributario/\(ruc)")
    }
    
    // MARK: - Deudas
    
    static func deudasPorIdentificacion(identificacion: String, tipoPersona: String) -> URL {
        API.baseURL.appending(path: "movil-servicios/api/v1.0/deudas/porIdentificacion/\(identificacion)")
            .appending(queryItems: [
                URLQueryItem(name: "tipoPersona", value: tipoPersona)
            ])
    }
    
    static func deudasPorNombre(nombre: String, tipoPersona: String, resultados: Int) -> URL {
        API.baseURL.appending(path: "movil-servicios/api/v1.0/deudas/porDenominacion/\(nombre)")
            .appending(queryItems: [
                URLQueryItem(name: "tipoPersona", value: tipoPersona),
                URLQueryItem(name: "resultados", value: String(resultados))
            ])
    }
    
    // MARK: - Login
    
    static let login = API.baseURL.appending(path: "movil-servicios/api/v2.0/secured")
    
    // MARK: - Banner
    
    static let banner = API.baseURL.appending(path: "movil-servicios/api/v1.0/banner")
    
}
