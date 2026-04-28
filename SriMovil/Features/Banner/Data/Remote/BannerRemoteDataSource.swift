//
//  BannerRemoteDataSource.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 28/4/26.
//

import Foundation

final class BannerRemoteDataSource: BannerRemoteDataSourceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func obtenerBanner() async throws -> BannerDto {
        try await networkService.get(url: .banner)
    }
}
