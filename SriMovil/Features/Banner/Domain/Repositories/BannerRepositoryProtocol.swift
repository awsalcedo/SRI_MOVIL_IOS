//
//  BannerRepositoryProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 28/4/26.
//

import Foundation

protocol BannerRepositoryProtocol: Sendable {
    func obtenerBanner() async throws -> BannerModel
}
