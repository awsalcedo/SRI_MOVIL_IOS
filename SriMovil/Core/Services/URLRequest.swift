//
//  URLRequest.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 16/4/26.
//

import Foundation

/// Define los tipos de autenticación soportados para las solicitudes HTTP.
///
/// Este enum encapsula las distintas estrategias utilizadas para autenticar
/// las peticiones hacia los servicios backend.
///
/// - Nota:
/// - `.basic` se utiliza típicamente en procesos de login.
/// - `.bearer` se utiliza para peticiones autenticadas con token (JWT).
enum AuthType {
    /// Autenticación Basic utilizando credenciales codificadas en Base64.
        ///
        /// - Parámetros:
        ///   - identificacion: Identificación del usuario (por ejemplo, RUC, cédula o pasaporte).
        ///   - password: Contraseña del usuario.
    case basic(identificacion: String, password: String)
    
    /// Autenticación mediante token Bearer.
        ///
        /// - Parámetro token: Token JWT o token de acceso proporcionado por el backend.
    case bearer(token: String)
}

/// Extensión que proporciona métodos de fábrica para construir instancias de `URLRequest`
/// con configuraciones comunes dentro de la capa de red.
///
/// Este enfoque permite:
/// - Centralizar la creación de requests.
/// - Mantener consistencia en métodos HTTP y timeouts.
/// - Reducir duplicación de código.
/// - Facilitar el mantenimiento y evolución de la capa de red.
///
/// - Importante:
/// No se establecen headers como `Accept` o `Content-Type` de forma global,
/// debido a que ciertos servicios del backend (por ejemplo, SRI) pueden responder
/// con tipos de contenido no estándar, lo cual puede provocar errores como
/// `406 Not Acceptable`.
extension URLRequest {
    
    // MARK: - GET
        
    /// Crea una solicitud HTTP GET con configuración por defecto.
    ///
    /// - Parámetro url: URL del endpoint.
    /// - Retorna: Una instancia de `URLRequest` configurada.
    ///
    /// Ejemplo:
    /// ```
    /// let request = URLRequest.jsonGET(url: .estadoTributario(ruc: "1790012345001"))
    /// ```
    ///
    /// - Nota:
    /// El header `Accept` se omite intencionalmente para evitar incompatibilidades
    /// con ciertos endpoints del backend.
    static func jsonGET(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        //request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    // MARK: - POST (Sin Body)
        
    /// Crea una solicitud HTTP POST sin cuerpo (body), opcionalmente aplicando autenticación.
    ///
    /// - Parámetros:
    ///   - url: URL del endpoint.
    ///   - auth: Tipo de autenticación opcional.
    /// - Retorna: Una instancia de `URLRequest` configurada.
    ///
    /// Ejemplo:
    /// ```
    /// let request = URLRequest.jsonPOST(
    ///     url: .login,
    ///     auth: .basic(identificacion: "0503061798001", password: "1234")
    /// )
    /// ```
    ///
    /// - Caso de uso:
    /// Utilizado comúnmente en endpoints donde las credenciales se envían
    /// mediante headers (por ejemplo, autenticación Basic).
    static func jsonPOST(url: URL, auth: AuthType? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60
        //request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let auth {
            request.applyAuth(auth)
        }
        return request
    }
    
    // MARK: - POST (Con Body)
        
    /// Crea una solicitud HTTP POST con un cuerpo codificado en JSON.
    ///
    /// - Parámetros:
    ///   - url: URL del endpoint.
    ///   - body: Objeto que será serializado a JSON (`Encodable`).
    ///   - auth: Tipo de autenticación opcional.
    ///   - encoder: Encoder JSON utilizado para serializar el body. Por defecto `JSONEncoder()`.
    ///
    /// - Retorna: Una instancia de `URLRequest` configurada.
    ///
    /// - Lanza: Un error si la serialización del body falla.
    ///
    /// Ejemplo:
    /// ```
    /// let request = try URLRequest.jsonPOST(
    ///     url: .crearUsuario,
    ///     body: requestDTO,
    ///     auth: .bearer(token: token)
    /// )
    /// ```
    ///
    /// - Importante:
    /// El body se codifica en formato JSON utilizando el encoder proporcionado.
    /// No se fuerzan headers globales como `Content-Type`, permitiendo flexibilidad
    /// según los requerimientos del backend.
    static func jsonPOST<Body: Encodable>(
            url: URL,
            body: Body,
            auth: AuthType? = nil,
            encoder: JSONEncoder = JSONEncoder()
        ) throws -> URLRequest {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.timeoutInterval = 60
            //request.setValue("application/json", forHTTPHeaderField: "Accept")
            //request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = try encoder.encode(body)
            
            if let auth {
                request.applyAuth(auth)
            }
            
            return request
        }
    
    // MARK: - Métodos Privados
        
    /// Aplica la estrategia de autenticación indicada al request.
    ///
    /// - Parámetro auth: Tipo de autenticación a aplicar.
    ///
    /// - Nota:
    /// Este método modifica el request agregando el header `Authorization`
    /// correspondiente según el tipo de autenticación.
    private mutating func applyAuth(_ auth: AuthType) {
        switch auth {
        case .basic(identificacion: let identificacion, password: let password):
            let credentials = "\(identificacion):\(password)".data(using: .utf8)!.base64EncodedString()
            setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
        case .bearer(token: let token):
            setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}
