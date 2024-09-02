//
//  BannerDomainError.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation

enum BannerDomainError: Error {
    case badURL
    case requestFailed(String)
    case clientError(String)
    case serverError(String)
    case decodingError(String)
    case unknownError
    case parsingError(String)
    case statusError(Int)
    case noDataAvailable
    case generico
}
