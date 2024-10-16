//
//  SriNetworkError.swift
//  SriMovil
//
//  Created by usradmin on 1/10/24.
//

import Foundation

// Enumeración optimizada con los posibles tipos de error en la red
public enum SriNetworkError: Error {
    /// Error general con el tipo `Error` como valor asociado.
    case general(Error)
    /// Error de estado HTTP, que contiene el valor de estado devuelto (código de estado).
    case status(Int)
    /// Error al decodificar el JSON (o codificación).
    case json(Error)
    /// URL mal formada o inválida.
    case badURL
    /// La respuesta no es del tipo HTTP.
    case noHTTP
    /// Error del cliente (4xx) con un mensaje opcional y un código de estado.
    case clientError(String?, Int)
    /// Error del servidor (5xx) con un mensaje opcional y un código de estado.
    case serverError(String?, Int)
    /// Error desconocido.
    case unknown
    
    /// Descripción textual de cada error para facilitar su uso en la UI.
    public var descripcion: String {
        switch self {
        case .general(let error):
            return "Error general: \(error.localizedDescription)"
        case .status(let code):
            return "Error HTTP con código de estado: \(code)"
        case .json(let error):
            return "Error al procesar el JSON: \(error.localizedDescription)"
        case .badURL:
            return "La URL proporcionada es inválida"
        case .noHTTP:
            return "La respuesta no es una conexión HTTP válida"
        case .clientError(let mensaje, let code):
            if let mensaje = mensaje {
                return mensaje
            } else {
                return "Error del cliente con código: \(code)"
            }
        case .serverError(let mensaje, let code):
            if let mensaje = mensaje {
                return "Error del servidor (\(code)): \(mensaje)"
            } else {
                return "Error del servidor con código: \(code)"
            }
        case .unknown:
            return "Ha ocurrido un error desconocido"
        }
    }
}
