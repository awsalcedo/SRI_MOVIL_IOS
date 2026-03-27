//
//  SriApiClient.swift
//  SriMovil
//
//  Created by usradmin on 14/11/24.
//

import Foundation

// MARK: - SriApiClientProtocol
/// El uso de protocolos proporciona un diseño flexible y facilita la inyección de dependencias, permitiendo crear versiones simuladas (mocks) del cliente de API para pruebas.
/// Esto es especialmente útil con las nuevas capacidades de prueba en Swift 5.9 e iOS 17, como SwiftTesting, que promueve un enfoque más modular y orientado a protocolos en lugar de usar clases concretas.

/// Protocolo para gestionar de manera modular las peticiones HTTP
protocol SriApiClientProtocol {
    /// Método genérico para realizar solicitudes http tipo GET
    ///  - Parameters:
    ///     - url: Ttipo `URL` utilizado para la petición.
    ///     - responseType: Tipo del `JSON` que vamos a devolver.
    ///
    ///  - Returns: El tipo genérico del `JSON` en el tipo `responseType` que será decodificado.
    ///  - Throws: El tipo ``SriNetworkError`` que nos informará del error que haya podido darse en la llamada.
    func getRequest<T: Codable>(
        url: URL,
        responseType: T.Type,
        authType: AuthenticationType
    ) async throws -> T
    
    /// Método genérico para realizar solicitudes http tipo POST
    ///  - Parameters:
    ///     - url: Ttipo `URL` utilizado para la petición.
    ///     - parameters: Arreglo de parámetros
    ///     - responseType: Tipo del `JSON` que vamos a devolver.
    ///
    ///  - Returns: El tipo genérico del `JSON` en el tipo `responseType` que será decodificado.
    ///  - Throws: El tipo ``SriNetworkError`` que nos informará del error que haya podido darse en la llamada.
    
    func postRequest<T: Codable>(
        url: URL,
        parameters: Encodable,
        responseType: T.Type,
        authType: AuthenticationType
    ) async throws -> T
    
}

// MARK: - SriApiClient

/* Swift requiere que las propiedades estáticas como `shared` en un singleton sean `Sendable` para que puedan usarse de forma segura en un contexto asincrónico.
 Para solucionarlo, debemos marcar el singleton `APIClient` como `Sendable` y asegurarnos de que no haya mutación compartida dentro de la clase.
 Para garantizar que `APIClient` sea seguro para la concurrencia, debe cumplir con `@unchecked Sendable`.
 Porqué es útil Singleton a SriApiClient:
 - Configuración compartida:
 Todas las peticiones de red comparten una configuración común, como URLSession, autenticación o manejo de errores.
 
 - Optimización:
 Reduce la sobrecarga de instanciar repetidamente el cliente de red.
 
 - Simplicidad:
 Facilita el acceso desde cualquier parte de la aplicación sin necesidad de pasar referencias manualmente.
 
 */

/// Implementación del SriApiClientProtocol esponsable de realizar las solicitudes HTTP y manejar las configuraciones relacionadas, incluido el decodificador de JSON

final class SriApiClient: SriApiClientProtocol, @unchecked Sendable {
    
    // Singleton
    public static let shared = SriApiClient()
    
    private let session: URLSession
    private let decoder: JSONDecoder
    private let authenticationManager: AuthenticationManagerProtocol
    private let errorHandler: ErrorHandlerProtocol
    
    /*
     Se inyecta URLSession por:
     - Testabilidad mejorada:
     Al inyectar un URLSession, puedes reemplazarlo con un objeto personalizado o un mock durante las pruebas unitarias. Esto permite simular respuestas de red sin realizar solicitudes reales.
     
     - Flexibilidad:
     En proyectos más grandes, puedes tener diferentes configuraciones de URLSession para manejar timeouts, caché o políticas específicas de manejo de red.
     
     - Independencia:
     El cliente SriApiClient no está acoplado a la implementación concreta de URLSession, lo que lo hace más modular.
     
     Para un diseño profesional y escalable, SIEMPRE deberías inyectar URLSession si:
     
     - Planeas realizar pruebas unitarias.
     - Manejas múltiples configuraciones de red o políticas específicas.
     - Buscas modularidad y desacoplamiento.
     
     Razones para inyectar JSONDecoder
     - Personalización:
     Puedes configurar el JSONDecoder para manejar formatos de fecha, claves específicas, o cualquier comportamiento especial requerido para las respuestas de la API.
     
     - Reutilización:
     Mantener una instancia reutilizable de JSONDecoder evita la necesidad de configurarlo en cada solicitud.
     
     - Testabilidad:
     Inyectar el JSONDecoder permite usar una versión personalizada o simulada en pruebas unitarias.
     Ejemplo:
     self.decoder.dateDecodingStrategy = .iso8601 // Ejemplo de configuración personalizada
     */
    
    private init(
        session: URLSession = defaultURLSession(),
        decoder: JSONDecoder = defaultJSONDecoder(),
        authenticationManager: AuthenticationManagerProtocol = AuthenticationManager(),
        errorHandler: ErrorHandlerProtocol = ErrorHandler()
    ) {
        self.session = session
        self.decoder = decoder
        self.authenticationManager = authenticationManager
        self.errorHandler = errorHandler
    }
    
    // Método específico para solicitudes GET
    func getRequest<T: Codable>(
        url: URL,
        responseType: T.Type,
        authType: AuthenticationType
    ) async throws -> T {
        try await makeRequest(
            url: url,
            method: HTTPMethods.get,
            parameters: nil as Empty?,
            responseType: responseType,
            authType: authType
        )
    }
    
    // Método específico para solicitudes POST
    func postRequest<T: Codable>(
        url: URL,
        parameters: Encodable,
        responseType: T.Type,
        authType: AuthenticationType
    ) async throws -> T {
        try await makeRequest(
            url: url,
            method: HTTPMethods.post,
            parameters: parameters,
            responseType: responseType,
            authType: authType
        )
    }
    
    // Método privado genérico para realizar la solicitud HTTP
    private func makeRequest<T: Codable, P: Encodable>(
        url: URL,
        method: HTTPMethods,
        parameters: P?,
        responseType: T.Type,
        authType: AuthenticationType
    ) async throws -> T {
        
        // Construcción de URLRequest
        let request = try buildRequest(url: url, method: method.rawValue, parameters: parameters, authType: authType)
        
        // Realizar la solicitud
        let (data, response) = try await session.data(for: request)
        
        // Pasar la tupla al ErrorHandler
        return try errorHandler.handleResponse(
            data: data,
            response: response, // Pasar URLResponse aquí
            responseType: responseType,
            decoder: decoder
        )
    }
    
    private func buildRequest<P: Encodable>(
        url: URL,
        method: String,
        parameters: P?,
        authType: AuthenticationType
    ) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        /// El operador & en Swift indica que se está pasando una variable por referencia a una función.
        /// Es decir, cualquier cambio que se haga a esa variable dentro de la función se reflejará fuera de ella.
        /// Esto es especialmente útil cuando trabajas con objetos mutables como URLRequest y necesitas modificarlos directamente en lugar de devolver una copia modificada.
        /// ¿Por qué se usa &request?
        /// El objeto URLRequest (que representa una solicitud HTTP) se pasa por referencia a las funciones:
        /// setCommonHeaders(for:)
        /// authenticationManager.addAuthenticationHeaders(to:)
        /// Esto permite que esas funciones puedan modificar directamente los valores dentro de request, como agregar encabezados o cambiar configuraciones, sin necesidad de devolver una nueva instancia.
                
        setCommonHeaders(for: &request)
        
        // Agregar encabezados de autenticación
        authenticationManager.addAuthenticationHeaders(to: &request, authType: authType)
        
        // Configuración de parámetros para POST
        if let parameters = parameters, method == HTTPMethods.post.rawValue {
            request.httpBody = try JSONEncoder().encode(parameters)
        }
        return request
    }
    
    /// La etiqueta for describe que la operación está relacionada "con el objeto request".
    /// El uso de inout permite que request se pase por referencia utilizando &request.
    private func setCommonHeaders(for request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Otros headers comunes podrían añadirse aquí
    }
    
    /// Configura un JSONDecoder con estrategias comunes para snake_case y fechas ISO8601.
    private static func defaultJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase //Para campos del JSON cuyos nombres no viene en camel case
        decoder.dateDecodingStrategy = .iso8601 // Configuración útil para APIs con fechas
        return decoder
    }
    
    /*
     Cuando decides personalizar la configuración de URLSession (como se muestra en tu ejemplo), dejas de usar el singleton URLSession.shared y, en su lugar, creas una instancia dedicada de URLSession con configuraciones específicas para tu cliente API.

     Esto te permite mayor flexibilidad y control sobre aspectos como los timeouts, las políticas de caché, y las cabeceras, sin afectar otros usos de URLSession.shared en el proyecto.

     Diferencia clave entre URLSession.shared y una instancia personalizada
        * URLSession.shared: Es una instancia singleton de URLSession con una configuración predeterminada adecuada para tareas simples y genéricas.
        * Instancia personalizada: Es una instancia única que configuras según las necesidades específicas de tu cliente API, sin interferir en otras partes del código.
     
     ¿Por qué no usar URLSession.shared aquí?
     En proyectos avanzados o en aquellos con requisitos de red más complejos, el singleton shared es limitado porque:

        1. No permite personalizar configuraciones como el timeout, la caché o las políticas de cabeceras.
        2. Podría generar conflictos si diferentes partes del proyecto necesitan configuraciones diferentes.
        3. No es test-friendly, ya que no se puede inyectar ni simular fácilmente para pruebas unitarias.
     
     */
    
    /// Configura una URLSession personalizada con tiempo de espera ajustado.
    private static func defaultURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // Timeout para cada request
        configuration.timeoutIntervalForResource = 60 // Timeout total para un recurso
        return URLSession(configuration: configuration)
    }
}

// Soporte para parámetros vacíos
struct Empty: Encodable {}

