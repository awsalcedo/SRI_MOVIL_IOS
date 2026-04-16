//
//  NetworkServiceProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 25/3/26.
//

import Foundation

/// Define el contrato de la capa de red de la aplicación.
///
/// Este protocolo abstrae las operaciones HTTP utilizadas para comunicarse
/// con el backend, permitiendo desacoplar la implementación concreta (`NetworkService`)
/// de las capas superiores como DataSources o Repositories.
///
/// Beneficios:
/// - Facilita la inyección de dependencias.
/// - Permite realizar pruebas unitarias mediante mocks.
/// - Define un punto único de entrada para operaciones de red.
///
/// - Important:
/// Todas las respuestas deben ser tipos que conformen a `Decodable & Sendable`,
/// garantizando compatibilidad con `async/await` y seguridad en concurrencia.
protocol NetworkServiceProtocol: Sendable {
    
    // MARK: - GET
        
    /// Ejecuta una solicitud HTTP GET y decodifica la respuesta al tipo esperado.
    ///
    /// - Parameter url: URL del endpoint a consumir.
    ///
    /// - Returns: Instancia del tipo `Response` decodificada desde el JSON recibido.
    ///
    /// - Throws:
    ///   - `NetworkError` en caso de error HTTP o problemas de red.
    ///   - `DecodingError` si la respuesta no puede convertirse al tipo esperado.
    ///
    /// Ejemplo:
    /// ```
    /// let response: EstadoTributarioDTO = try await networkService.get(
    ///     url: .estadoTributario(ruc: ruc)
    /// )
    ///
    func get<Response: Decodable & Sendable>(url: URL) async throws -> Response
    
    // MARK: - POST (Sin Body)
        
    /// Ejecuta una solicitud HTTP POST sin cuerpo (`body`), opcionalmente con autenticación,
    /// y decodifica la respuesta al tipo esperado.
    ///
    /// - Parameters:
    ///   - url: URL del endpoint a consumir.
    ///   - auth: Tipo de autenticación opcional (`Basic` o `Bearer`).
    ///
    /// - Returns: Instancia del tipo `Response` decodificada desde el JSON recibido.
    ///
    /// - Throws:
    ///   - `NetworkError` en caso de error HTTP o problemas de red.
    ///   - `DecodingError` si la respuesta no puede convertirse al tipo esperado.
    ///
    /// - Caso de uso:
    /// Este método es ideal para endpoints que reciben credenciales a través de headers,
    /// como el proceso de login mediante `Basic Auth`.
    ///
    /// Ejemplo:
    /// ```
    /// let response: LoginResponseDTO = try await networkService.post(
    ///     url: .secured,
    ///     auth: .basic(identificacion: identificacion, password: password)
    /// )
    ///
    func post<Response: Decodable & Sendable>(url: URL, auth: AuthType?) async throws -> Response
    
    // MARK: - POST (Con Body)
        
    /// Ejecuta una solicitud HTTP POST con un cuerpo (`body`) codificado en JSON
    /// y decodifica la respuesta al tipo esperado.
    ///
    /// - Parameters:
    ///   - url: URL del endpoint a consumir.
    ///   - body: Objeto que será serializado a JSON (`Encodable`) y enviado en el request.
    ///   - auth: Tipo de autenticación opcional (`Basic` o `Bearer`).
    ///
    /// - Returns: Instancia del tipo `Response` decodificada desde el JSON recibido.
    ///
    /// - Throws:
    ///   - Error de codificación si el `body` no puede serializarse.
    ///   - `NetworkError` en caso de error HTTP o problemas de red.
    ///   - `DecodingError` si la respuesta no puede convertirse al tipo esperado.
    ///
    /// - Caso de uso:
    /// Utilizado en endpoints que requieren envío de datos en formato JSON,
    /// como creación o actualización de recursos.
    ///
    /// Ejemplo:
    /// ```
    /// let response: CrearCuentaResponseDTO = try await networkService.post(
    ///     url: .crearCuenta,
    ///     body: requestDTO,
    ///     auth: .bearer(token: token)
    /// )
    ///
    func post<Body: Encodable & Sendable, Response: Decodable & Sendable>(
        url: URL,
        body: Body,
        auth: AuthType?
    ) async throws -> Response
}
