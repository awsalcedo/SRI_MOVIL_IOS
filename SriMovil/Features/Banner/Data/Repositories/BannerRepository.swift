//
//  BannerRepository.swift
//  SriMovil
//
//  Created by usradmin on 28/4/26.
//

import Foundation

final class BannerRepository: BannerRepositoryProtocol {
    private let remoteDataSource: BannerRemoteDataSourceProtocol
    
    init(remoteDataSource: BannerRemoteDataSourceProtocol = BannerRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func obtenerBanner() async throws -> BannerModel {
        let dto = try await remoteDataSource.obtenerBanner()
        return BannerMapper.toDomain(dto)
    }
}
