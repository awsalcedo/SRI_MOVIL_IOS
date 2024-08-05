//
//  InfoVehiculoDomainError.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

// Define un enum para los posibles errores de dominio relacionados con la información del vehículo

enum InfoVehiculoDomainError: Error {
    case badURL
    case requestFailed(String)
    case clientError(String)
    case serverError(String)
    case decodingError(String)
    case unknownError
    case parsingError(String)
    case statusError(Int)
    case vehiculoNoEncontrado(String)
    case generico
}
