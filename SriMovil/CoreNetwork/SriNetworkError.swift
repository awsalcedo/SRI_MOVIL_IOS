//
//  SriNetworkError.swift
//  SriMovil
//
//  Created by usradmin on 1/10/24.
//

import Foundation

/// Enumeración con los posibles tipos de error
public enum SriNetworkError: Error {
    /// Caso de error general con el tipo `Error` como valor asociado.
    case general(Error)
    /// Caso de error de estado HTTP que tendrá embebido el valor de estado devuelto en un `Int`
    case status(Int)
    /// Error en la decodificación del JSON (o codificación) por algún error en el mismo. Lleva el tipo `Error` porque al imprimir el tipo completo tendremos una descripción más larga con el error concreto que ha habido.
    case json(Error)
    /// Tipo de dato no válido a lo que se esperaba.
    case dataNotValid
    /// Error que ha sido devuelto porque el `URLResponse` que se ha devuelto no es el del tipo `HTTPURLResponse`
    /// Error de url
    case badURL
    case noHTTP
    /// Error desconocido
    case unknown
    
    /// Permite saber de una manera textual y extrayendo los tipos asociados de la enumeración, qué ha pasado, preparado para ser mostrado al usuario en algún tipo de alerta dentro la UI.
    public var descripcion: String {
        switch self {
        case .general(let error):
            return "Error general: \(error.localizedDescription)"
        case .status(let code):
            return "Error HTTP con status: \(code)"
        case .json(let error):
            return "Error en el JSON: \(error.localizedDescription)"
        case .dataNotValid:
            return "Datos no válidos"
        case .badURL:
            return "URL inválida"
        case .noHTTP:
            return "No es una conexión HTTP válida"
        case .unknown:
            return "Error desconocido"
        }
    }
    
}
