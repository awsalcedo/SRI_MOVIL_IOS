//
//  BannerRepositoryType.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation

protocol BannerRepositoryType {
    func obtenerBanner() async -> Result<BannerModel, BannerDomainError>
}
