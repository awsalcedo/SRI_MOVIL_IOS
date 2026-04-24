//
//  NetworkService.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 25/3/26.
//

import Foundation

/// Implementación concreta de la capa de red de la aplicación.
///
/// `NetworkService` es responsable de:
/// - construir y ejecutar solicitudes HTTP a través de `URLSession`,
/// - decodificar respuestas JSON a tipos `Decodable`,
/// - codificar cuerpos de solicitud para operaciones `POST`,
/// - validar códigos de estado HTTP,
/// - mapear errores de red a `NetworkError`.
///
/// Este servicio centraliza la lógica común de comunicación con el backend,
/// permitiendo que los data sources o repositorios deleguen en una única
/// abstracción la ejecución de requests.
///
/// - Important:
/// Este servicio trabaja con tipos genéricos `Decodable` y `Encodable` para
/// mantener flexibilidad y reutilización en distintos endpoints.
///
/// - Note:
/// La instancia puede configurarse con una `URLSession` personalizada,
/// lo cual facilita pruebas unitarias, mocking y configuraciones específicas
/// de red como SSL Pinning.
final class NetworkService: NetworkServiceProtocol, Sendable {
    
    // MARK: - Propiedades Privadas
    
    /// Sesión utilizada para ejecutar solicitudes HTTP.
    ///
    /// Puede ser inyectada externamente para pruebas o configuraciones
    /// especiales de red. Si no se proporciona, se crea una sesión
    /// por defecto con el delegate correspondiente.
    private let session: URLSession
    
    /// Decoder centralizado para transformar respuestas JSON en modelos Swift.
    ///
    /// Se configura con estrategias comunes de decodificación utilizadas
    /// por los servicios del backend.
    private let decoder: JSONDecoder
    
    /// Encoder centralizado para serializar cuerpos de solicitudes `POST`.
    ///
    /// Se reutiliza para evitar crear nuevas instancias innecesarias y
    /// mantener una configuración consistente.
    private let encoder: JSONEncoder
    
    /// Delegate utilizado por `URLSession` para manejo de SSL Pinning.
    ///
    /// Se mantiene como referencia fuerte porque `URLSession` depende de él
    /// durante su ciclo de vida.
    private let pinningDelegate: SSLPinningDelegate?
    
    // MARK: - Inicializador
    
    /// Crea una nueva instancia de `NetworkService`.
    ///
    /// - Parameters:
    ///   - session: Sesión personalizada para ejecutar requests. Si se omite,
    ///     se crea una `URLSession` por defecto.
    ///   - enableSSLPinning: Indica si debe prepararse la sesión con soporte
    ///     para SSL Pinning.
    ///
    /// - Note:
    /// Actualmente el pinning está deshabilitado a nivel de configuración
    /// (`isPinningEnabled: false`) para ambientes de prueba. En producción
    /// debe habilitarse con los hashes configurados correctamente.
    init(
        session: URLSession? = nil,
        enableSSLPinning: Bool = true
    ) {
        
        // SSL Pinning is disabled for test server — enable for production
        let delegate = enableSSLPinning ? SSLPinningDelegate(
            pinnedHashes: [],
            isPinningEnabled: false
        ): nil
        
        self.pinningDelegate = delegate
        
        if let session {
            self.session = session
        } else {
            self.session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
        }
        
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        //self.decoder.dateDecodingStrategy = .iso8601
        
        self.decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            
            if let timestamp = try? container.decode(Double.self) {
                return Date(timeIntervalSince1970: timestamp / 1000)
            }
            
            if let dateString = try? container.decode(String.self) {
                let isoFormatter = ISO8601DateFormatter()
                
                if let date = isoFormatter.date(from: dateString) {
                    return date
                }
            }
            
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Formato de fecha no soportado"
            )
        }
        
        self.encoder = JSONEncoder()
    }
    
    // MARK: - Funciones Públicas
    
    /// Ejecuta una solicitud HTTP GET y decodifica la respuesta al tipo esperado.
    ///
    /// - Parameter url: URL del endpoint a consumir.
    /// - Returns: Instancia decodificada del tipo `Response`.
    ///
    /// - Throws:
    ///   - `NetworkError` si la respuesta HTTP no es válida o el backend devuelve
    ///     un código de error conocido.
    ///   - `DecodingError` si la respuesta no puede transformarse al modelo esperado.
    ///
    /// Ejemplo:
    /// ```
    /// let response: EstadoTributarioDTO = try await networkService.get(url: .estadoTributario(ruc: ruc))
    ///
    func get<Response: Decodable & Sendable>(url: URL) async throws -> Response {
        let request = URLRequest.jsonGET(url: url)
        return try await perform(request)
    }
    
    /// Ejecuta una solicitud HTTP POST sin cuerpo (`body`) y decodifica la respuesta.
    ///
    /// Este método es útil para endpoints que reciben autenticación mediante headers,
    /// pero no requieren un cuerpo JSON en la solicitud.
    ///
    /// - Parameters:
    ///   - url: URL del endpoint a consumir.
    ///   - auth: Tipo de autenticación opcional que será aplicado al request.
    ///
    /// - Returns: Instancia decodificada del tipo `Response`.
    ///
    /// - Throws:
    ///   - `NetworkError` si la respuesta HTTP no es válida o el backend devuelve
    ///     un código de error conocido.
    ///   - `DecodingError` si la respuesta no puede transformarse al modelo esperado.
    ///
    /// Ejemplo:
    /// ```
    /// let response: LoginResponseDTO = try await networkService.post(
    ///     url: .secured,
    ///     auth: .basic(identificacion: identificacion, password: password)
    /// )
    ///
    func post<Response: Decodable & Sendable>(url: URL, auth: AuthType? = nil) async throws -> Response {
        let request = URLRequest.jsonPOST(url: url, auth: auth)
        return try await perform(request)
    }
    
    /// Ejecuta una solicitud HTTP POST con cuerpo (`body`) codificado en JSON
    /// y decodifica la respuesta al tipo esperado.
    ///
    /// - Parameters:
    ///   - url: URL del endpoint a consumir.
    ///   - body: Objeto que será codificado como JSON y enviado en el cuerpo de la solicitud.
    ///   - auth: Tipo de autenticación opcional que será aplicado al request.
    ///
    /// - Returns: Instancia decodificada del tipo `Response`.
    ///
    /// - Throws:
    ///   - Un error de codificación si el `body` no puede serializarse correctamente.
    ///   - `NetworkError` si la respuesta HTTP no es válida o el backend devuelve
    ///     un código de error conocido.
    ///   - `DecodingError` si la respuesta no puede transformarse al modelo esperado.
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
        auth: AuthType? = nil
    ) async throws -> Response {
        let request = try URLRequest.jsonPOST(
            url: url,
            body: body,
            auth: auth,
            encoder: encoder
        )
        return try await perform(request)
    }
    
    // MARK: - Funciones Privadas
    
    /// Ejecuta el `URLRequest`, valida la respuesta HTTP y decodifica el cuerpo
    /// al tipo esperado.
    ///
    /// - Parameter request: Solicitud HTTP previamente construida.
    /// - Returns: Instancia decodificada del tipo `Response`.
    ///
    /// - Throws:
    ///   - Errores de transporte lanzados por `URLSession` (por ejemplo, sin internet,
    ///     timeout, DNS, handshake SSL).
    ///   - `NetworkError` si el código HTTP no corresponde a un resultado exitoso.
    ///   - `DecodingError` si el cuerpo no puede decodificarse al modelo solicitado.
    ///
    /// - Note:
    /// Si la ejecución falla antes de recibir una respuesta HTTP válida,
    /// el flujo no llegará a `validateResponse(data:response:)`.
    private func perform<Response: Decodable & Sendable>(_ request: URLRequest) async throws -> Response {
        // Si aquí falla por: no internet, DNS no resuelve, servidor caído, timeout , SSL falla, da un URLError y no pasa al validateResponse()
        let(data, response) = try await session.dataHTTP(for: request)
        print("Response:", response)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Body:", jsonString)
        }
        
        try validateResponse(data: data, response: response)
        return try decoder.decode(Response.self, from: data)
    }
    
    /// Valida el código de estado HTTP y transforma respuestas de error
    /// a instancias de `NetworkError`.
    ///
    /// - Parameters:
    ///   - data: Cuerpo de la respuesta recibido desde el backend.
    ///   - response: Respuesta HTTP asociada al request.
    ///
    /// - Throws: Un `NetworkError` según el código de estado retornado.
    ///
    /// - Important:
    /// Los estados `200...299` se consideran exitosos. El resto de códigos se
    /// transforman a errores tipados para facilitar su manejo en capas superiores.
    ///
    /// - Note:
    /// En los estados `401` y `404`, si la respuesta contiene JSON compatible con
    /// `SRIErrorResponseDTO`, se intenta extraer el mensaje proporcionado
    /// por el backend para enriquecer el error.
    private func validateResponse(data: Data, response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200...299:
            return
            
        case 400:
            throw NetworkError.badRequest
            
        case 401:
            let contentType = response.value(forHTTPHeaderField: "Content-Type") ?? ""
            
            if contentType.localizedCaseInsensitiveContains("application/json"),
               let backError = try? decoder.decode(SRIErrorResponseDTO.self, from: data) {
                throw NetworkError.unauthorized(message: backError.mensaje)
            } else {
                throw NetworkError.unauthorized()
            }
            
        case 404:
            let contentType = response.value(forHTTPHeaderField: "Content-Type") ?? ""
            
            if contentType.localizedCaseInsensitiveContains("application/json"),
               let backError = try? decoder.decode(SRIErrorResponseDTO.self, from: data) {
                throw NetworkError.notFound(message: backError.mensaje)
            } else {
                throw NetworkError.serverError(response.statusCode)
            }
            
        case 406:
            throw NetworkError.notAcceptable
            
        case 422:
            throw NetworkError.validateError
            
        case 500...599:
            throw NetworkError.serverError(response.statusCode)
            
        default:
            throw NetworkError.unknown(response.statusCode)
        }
    }
    
}
