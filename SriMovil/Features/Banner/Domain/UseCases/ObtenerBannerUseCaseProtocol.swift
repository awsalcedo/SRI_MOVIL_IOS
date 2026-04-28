//
//  ObtenerBannerUseCaseProtocol.swift
//  SriMovil
//
//  Created by usradmin on 28/4/26.
//

import Foundation

protocol ObtenerBannerUseCaseProtocol: Sendable {
    func execute() async throws -> BannerModel
}
