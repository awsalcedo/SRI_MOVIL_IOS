//
//  BannerRemoteDataSourceProtocol.swift
//  SriMovil
//
//  Created by usradmin on 28/4/26.
//

import Foundation

protocol BannerRemoteDataSourceProtocol: Sendable {
    func obtenerBanner() async throws -> BannerDto
}
