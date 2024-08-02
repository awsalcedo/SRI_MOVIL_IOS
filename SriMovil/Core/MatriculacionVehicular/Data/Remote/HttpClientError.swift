//
//  HttpClientError.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

enum HttpClientError: Error {
    case clientError
    case serverError
    case generico
    case parsingError
    case badURL
    case responseError
    case tooManyRequests
    case unknownError
}
