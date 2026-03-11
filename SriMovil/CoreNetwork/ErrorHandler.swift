//
//  ErrorHandler.swift
//  SriMovil
//
//  Created by usradmin on 15/11/24.
//

import Foundation

// MARK: - ErrorHandlerProtocol

/// Protocolo para manejar errores de red

protocol ErrorHandlerProtocol {
    
    //// Maneja la validación de la respuesta del servidor y la decodificación de datos.
    /// - Parameters:
    ///   - data: Los datos de la respuesta.
    ///   - response: La respuesta HTTP recibida.
    ///   - responseType: El tipo esperado para decodificar la respuesta.
    ///   - decoder: El decodificador JSON.
    /// - Returns: Una instancia decodificada del tipo especificado.
    /// - Throws: Un error de tipo `SriNetworkError`.
    ///
    func handleResponse<T: Codable>(
        data: Data,
        response: URLResponse,
        responseType: T.Type,
        decoder: JSONDecoder
    ) throws -> T
}

// MARK: - ErrorHandler

/// Implementación del ErrorHandlerProtocol

final class ErrorHandler: ErrorHandlerProtocol {
    
    func handleResponse<T: Codable>(
        data: Data,
        response: URLResponse,
        responseType: T.Type,
        decoder: JSONDecoder
    ) throws -> T {
        
        // Verificación de la respuesta del servidor
        guard let httpResponse = response as? HTTPURLResponse else {
            throw SriNetworkError.noHTTP
        }

        switch httpResponse.statusCode {
        case 200...299:
            // Decodificación en caso de éxito
            return try decodeResponse(data: data, responseType: responseType, decoder: decoder)
        case 400...499:
            // Errores del servidor (400)
            throw handleClientError(data: data, response: httpResponse, decoder: decoder)
        case 500...599:
            // Errores del servidor (500)
            throw handleServerError(data: data, response: httpResponse, decoder: decoder)
        default:
            throw SriNetworkError.unknownStatus(httpResponse.statusCode)
        }
    }
    
    private func decodeResponse<T: Codable>(
        data: Data,
        responseType: T.Type,
        decoder: JSONDecoder
    ) throws -> T {
        do {
            return try decoder.decode(responseType, from: data)
        } catch {
            throw SriNetworkError.json(error)
        }
    }
        
    private func handleClientError(
        data: Data,
        response: HTTPURLResponse,
        decoder: JSONDecoder
    ) -> SriNetworkError {
        do {
            // Intentar decodificar el error en el modelo `ErrorResponse`
            let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
            return .clientError(errorResponse.mensaje, response.statusCode)
        } catch {
            // Si falla la decodificación, devolver un error genérico con más detalles
            return .clientError("No se pudo procesar la respuesta del cliente. Código: \(response.statusCode)", response.statusCode)
        }
    }

    private func handleServerError(
        data: Data,
        response: HTTPURLResponse,
        decoder: JSONDecoder
    ) -> SriNetworkError {
        do {
            // Intentar decodificar el error en el modelo `ErrorResponse`
            let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
            return .serverError(errorResponse.mensaje, response.statusCode)
        } catch {
            // Si falla la decodificación, devolver un error genérico con más detalles
            return .serverError("No se pudo procesar la respuesta del servidor. Código: \(response.statusCode)", response.statusCode)
        }
    }
    
}

