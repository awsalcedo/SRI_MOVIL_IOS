//
//  ObtenerBannerUseCase.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation
import Factory

protocol ObtenerBannerUseCaseType {
    func excecute() async -> Result<BannerModel, BannerDomainError>
}


class ObtenerBannerUseCase: ObtenerBannerUseCaseType {
    
    @Injected(\.bannerRepository) private var repository
    
    func excecute() async -> Result<BannerModel, BannerDomainError> {
        return await repository.obtenerBanner()
    }
    
}
