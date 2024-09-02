//
//  BannerContainer.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation
import Factory

extension Container {
    
    // Network
    var bannerApi: Factory<BannerApiType> {
        self { BannerApi() }.singleton
    }
    
    // DataSources
    var bannerRemoteDataSource: Factory<BannerRemoteDataSourceType> {
        self { BannerRemoteDataSource() }.singleton
    }
    
    var bannerLocalDataSource: Factory<BannerLocalDataSourceType> {
        self { BannerLocalDataSource() }.singleton
    }
    
    var errorBannerMapper: Factory<BannerDomainErrorMapper> {
        self { BannerDomainErrorMapper() }.singleton
    }
    
    // Repositories
    var bannerRepository: Factory<BannerRepositoryType> {
        self { BannerRepository() }.singleton
    }
    
    // UseCases
    var obtenerBannerUsecase: Factory<ObtenerBannerUseCaseType> {
        self { ObtenerBannerUseCase() }.singleton
    }
    
    // ViewModels
    var obtenerBannerViewModel: Factory<BannerViewModel> {
        self { BannerViewModel() }
    }
}
