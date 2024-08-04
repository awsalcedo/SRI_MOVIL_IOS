//
//  HttpClientErrorMapper.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct HttpClientErrorMapper {
    static func map(error: Error) -> HttpClientError {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .badURL:
                return .badURL
            case .timedOut:
                return .unknownError
            default:
                return .unknownError
            }
        }
        
        return .unknownError
    }
}
