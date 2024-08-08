//
//  BannerRepository.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation
import Factory

class BannerRepository: BannerRepositoryType {
    @Injected(\.bannerRemoteDataSource) private var remoteDataSource
    @Injected(\.errorBannerMapper) private var errorMapper
    
    func obtenerBanner() async -> Result<BannerModel, BannerDomainError> {
        let result: Result<BannerModel, HttpClientError> = await remoteDataSource.obtenerBanner()
        
        /// TODO
        ///  Falta al macenar en local la imagen para que use las siguientes veces la imagen obtenida del local y la vuelva a pedir a la API sólo si la fecha de banner a cambiado.
        
        switch result {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            let domainError = errorMapper.map(error: error)
            return .failure(domainError)
        }
    }
}
