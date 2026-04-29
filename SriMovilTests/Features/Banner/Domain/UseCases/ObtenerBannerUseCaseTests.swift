//
//  ObtenerBannerUseCaseTests.swift
//  SriMovilTests
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 29/4/26.
//

import Testing
@testable import SriMovil

@Suite("ObtenerBannerUseCase Tests")
struct ObtenerBannerUseCaseTests {
    
    // MARK: - Subject Under Test
    
    let sut: ObtenerBannerUseCase
    
    // MARK: - Mocks
    
    let mockRepository: MockBannerRepository
    
    @Test func <#test name#>() async throws {
        <#body#>
    }
    
    
}

// MARK: - Mock Repository

private final class MockBannerRepository: BannerRepositoryProtocol {
    
    var obtenerBannerWasCalled = false
    var shouldThrowError = false
    var errorToThrow: Error = NetworkError.unknown(0)
    
    var bannerToReturn = BannerModel(
        imagen64: "data:image/png;base64,dGVzdA==",
        url: "https://www.sri.gob.ec",
        predeterminado: true
    )
    
    func obtenerBanner() async throws -> BannerModel {
        obtenerBannerWasCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return bannerToReturn
    }
}
