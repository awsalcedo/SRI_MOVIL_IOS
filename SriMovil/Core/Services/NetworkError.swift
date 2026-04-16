//
//  NetworkError.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 25/3/26.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case badRequest
    case unauthorized
    case notFound(message: String? = nil)
    case validateError
    case notAcceptable
    case serverError(Int)
    case unknown(Int)
}
