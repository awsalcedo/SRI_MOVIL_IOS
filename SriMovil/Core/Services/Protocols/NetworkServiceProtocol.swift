//
//  NetworkServiceProtocol.swift
//  SriMovil
//
//  Created by usradmin on 25/3/26.
//

import Foundation

protocol NetworkServiceProtocol: Sendable {
    func get<T: Decodable & Sendable>(endpoint: String) async throws -> T
}
