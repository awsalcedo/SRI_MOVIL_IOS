//
//  BannerRemoteDataSourceProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 28/4/26.
//

import Foundation

protocol BannerRemoteDataSourceProtocol: Sendable {
    func obtenerBanner() async throws -> BannerDto
}
