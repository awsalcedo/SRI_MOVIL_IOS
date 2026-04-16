//
//  URLSession.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 16/4/26.
//

import Foundation

/// Extensión de `URLSession` que encapsula la ejecución de solicitudes HTTP
/// y garantiza que la respuesta sea de tipo `HTTPURLResponse`.
///
/// Este método abstrae la llamada estándar `data(for:)` de `URLSession`,
/// agregando validación del tipo de respuesta y simplificando el uso en la
/// capa de red.
///
/// Beneficios:
/// - Reduce duplicación de código al validar el tipo de respuesta.
/// - Garantiza que siempre se trabaje con `HTTPURLResponse`.
/// - Mejora la legibilidad y mantenibilidad del código.
///
/// - Important:
/// Este método no valida códigos de estado HTTP (200, 400, etc.).
/// Esa responsabilidad pertenece a la capa superior (`NetworkService`).
///
/// - Note:
/// Si ocurre un error de red (por ejemplo, sin conexión, timeout, fallo SSL),
/// se lanzará directamente el error producido por `URLSession`.
extension URLSession {
    
    /// Ejecuta una solicitud HTTP y retorna los datos junto con la respuesta HTTP validada.
    ///
    /// - Parameter request: La solicitud `URLRequest` a ejecutar.
    ///
    /// - Returns: Una tupla que contiene:
    ///   - `Data`: El cuerpo de la respuesta.
    ///   - `HTTPURLResponse`: La respuesta HTTP validada.
    ///
    /// - Throws:
    ///   - Error de red (`URLError`) si la ejecución falla (sin conexión, timeout, etc.).
    ///   - `NetworkError.invalidResponse` si la respuesta no es de tipo `HTTPURLResponse`.
    ///
    /// Ejemplo:
    /// ```
    /// let (data, response) = try await session.dataHTTP(for: request)
    /// ```
    ///
    /// - Important:
    /// Este método no realiza parsing ni validación de códigos de estado.
    /// Solo garantiza que la respuesta sea HTTP válida.
    func dataHTTP(for request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        return (data, httpResponse)
    }
}
