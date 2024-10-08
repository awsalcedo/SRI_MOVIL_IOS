//
//  HTTPMethods.swift
//  SriMovil
//
//  Created by usradmin on 1/10/24.
//

import Foundation

/// Enumeración que representa los principales métodos HTTP utilizados en las solicitudes web.
public enum HTTPMethods: String {
    /// Método utilizado para solicitar datos de un recurso.
    case get = "GET"
    
    /// Método utilizado para enviar datos para ser procesados a un recurso. Es comúnmente utilizado cuando se envía información de formularios.
    case post = "POST"
    
    /// Método utilizado para actualizar un recurso existente o crearlo si no existe.
    case put = "PUT"
    
    /// Método utilizado para aplicar modificaciones parciales a un recurso.
    case patch = "PATCH"
    
    /// Método utilizado para eliminar un recurso especificado.
    case delete = "DELETE"
}
