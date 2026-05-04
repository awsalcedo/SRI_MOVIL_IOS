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
    
    private let mockRepository: MockBannerRepository
    
    // MARK: - Initializers
    
    init() {
        mockRepository = MockBannerRepository()
        sut = ObtenerBannerUseCase(repository: mockRepository)
    }
    
    // MARK: - execute Tests
    
    @Test("execute returns banner when repository succeeds")
    func executeReturnsBannerWhenRepositorySucceeds() async throws {
        // Given
        let expectedBanner = BannerModel(
            imagen64: "data:image/png;base64,dGVzdA==",
            url: "https://www.sri.gob.ec",
            predeterminado: true
        )
        mockRepository.bannerToReturn = expectedBanner
        
        // When
        let banner = try await sut.execute()
        
        // Then
        #expect(mockRepository.obtenerBannerWasCalled)
        #expect(banner == expectedBanner)
    }
    
    @Test("execute propagates server error when repository fails")
    func executePropagatesServerErrorWhenRepositoryFails() async throws {
        // Given
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NetworkError.serverError(500)
        
        do {
            // When
            _ = try await sut.execute()
            
            // Then
            Issue.record("Expected NetworkError.serverError(500) to be thrown")
        } catch {
            // Then
            #expect(mockRepository.obtenerBannerWasCalled)
            #expect(error as? NetworkError == .serverError(500))
        }
    }
    
    @Test("execute propagates unauthorized error when repository fails")
    func executePropagatesUnauthorizedErrorWhenRepositoryFails() async throws {
        // Given
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NetworkError.unauthorized()
        
        do {
            // When
            _ = try await sut.execute()
            
            // Then
            Issue.record("Expected NetworkError.unauthorized to be thrown")
        } catch {
            // Then
            #expect(mockRepository.obtenerBannerWasCalled)
            #expect(error as? NetworkError == .unauthorized())
        }
    }
    
    @Test("execute propagates not found error when repository fails")
    func executePropagatesNotFoundErrorWhenRepositoryFails() async throws {
        // Given
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NetworkError.notFound()
        
        do {
            // When
            _ = try await sut.execute()
            
            // Then
            Issue.record("Expected NetworkError.notFound to be thrown")
        } catch {
            // Then
            #expect(mockRepository.obtenerBannerWasCalled)
            #expect(error as? NetworkError == .notFound())
        }
    }
}

// MARK: - Mock Repository

private final class MockBannerRepository: BannerRepositoryProtocol, @unchecked Sendable {
    
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
