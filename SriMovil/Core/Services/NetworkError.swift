//
//  NetworkError.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 25/3/26.
//

import Foundation

/// Define los errores tipados de la capa de red de la aplicación.
///
/// `NetworkError` permite representar de forma uniforme errores HTTP,
/// respuestas inválidas y estados no controlados del backend.
///
/// - Important:
/// Este enum es global y es consumido por múltiples features.
/// Cualquier ajuste debe mantenerse compatible con el resto del proyecto.
enum NetworkError: LocalizedError, Equatable {
    
    /// La URL construida no es válida.
    case invalidURL
    
    /// La respuesta recibida no corresponde a una respuesta HTTP válida.
    case invalidResponse
    
    /// El backend devolvió un error `400 Bad Request`.
    case badRequest
    
    /// El backend devolvió un error `401 Unauthorized`.
    ///
    /// - Parameter message: Mensaje opcional retornado por el backend.
    ///   Este valor permite enriquecer el manejo de errores en features
    ///   como Login, donde el servidor puede devolver causas específicas
    ///   de autenticación fallida.
    case unauthorized(message: String? = nil)
    
    /// El recurso solicitado no fue encontrado.
    ///
    /// - Parameter message: Mensaje opcional retornado por el backend.
    case notFound(message: String? = nil)
    
    /// El backend devolvió un error `422 Unprocessable Entity`.
    case validateError
    
    /// El backend devolvió un error `406 Not Acceptable`.
    case notAcceptable
    
    /// El backend devolvió un error de servidor `5xx`.
    ///
    /// - Parameter Int: Código HTTP retornado.
    case serverError(Int)
    
    /// El backend devolvió un estado HTTP no controlado explícitamente.
    ///
    /// - Parameter Int: Código HTTP retornado.
    case unknown(Int)
}
