//
//  HttpClientError.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

enum HttpClientError: Error {
    case badURL
    case requestFailed(Error)
    case statusError(Int)
    case decodingError(Error)
    case unknownError
    case parsingError
}
