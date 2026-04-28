//
//  ObtenerBannerUseCase.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 28/4/26.
//

import Foundation

final class ObtenerBannerUseCase: ObtenerBannerUseCaseProtocol {
    private let repository: BannerRepositoryProtocol
    
    init(repository: BannerRepositoryProtocol = BannerRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> BannerModel {
        try await repository.obtenerBanner()
    }
}
