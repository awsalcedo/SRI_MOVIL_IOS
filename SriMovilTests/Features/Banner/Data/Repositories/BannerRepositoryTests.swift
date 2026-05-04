//
//  BannerRepositoryTests.swift
//  SriMovilTests
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 4/5/26.
//

import Testing
@testable import SriMovil

@Suite("BannerRepository Tests")
struct BannerRepositoryTests {
    
    // MARK: - Subject Under Test
    
    private let sut: BannerRepository
    
    // MARK: - Mocks
    
    private let remoteDataSource: MockBannerRemoteDataSource
    
    // MARK: - Initializers
    
    init() {
        remoteDataSource = MockBannerRemoteDataSource()
        sut = BannerRepository(remoteDataSource: remoteDataSource)
    }
    
    // MARK: - obtenerBanner Tests
    
    @Test("obtenerBanner returns domain model when remote data source succeeds")
    func obtenerBannerReturnsDomainModelWhenRemoteDataSourceSucceeds() async throws {
        // Given
        let dto = BannerDto(
            imagen64: "data:image/png;base64,dGVzdA==",
            url: "https://www.sri.gob.ec",
            predeterminado: true
        )
        remoteDataSource.dtoToReturn = dto
        
        // When
        let banner = try await sut.obtenerBanner()
        
        // Then
        #expect(remoteDataSource.obtenerBannerWasCalled)
        #expect(banner.imagen64 == dto.imagen64)
        #expect(banner.url == dto.url)
        #expect(banner.predeterminado == dto.predeterminado)
    }
    
    @Test("obtenerBanner propagates error when remote data source fails")
    func obtenerBannerPropagatesErrorWhenRemoteDataSourceFails() async throws {
        // Given
        remoteDataSource.shouldThrowError = true
        remoteDataSource.errorToThrow = NetworkError.serverError(500)
        
        do {
            // When
            _ = try await sut.obtenerBanner()
            
            // Then
            Issue.record("Expected NetworkError.serverError(500) to be thrown")
        } catch {
            // Then
            #expect(remoteDataSource.obtenerBannerWasCalled)
            #expect(error as? NetworkError == .serverError(500))
        }
    }
}

// MARK: - Mock Remote Data Source

private final class MockBannerRemoteDataSource: BannerRemoteDataSourceProtocol, @unchecked Sendable {
    
    var obtenerBannerWasCalled = false
    var shouldThrowError = false
    var errorToThrow: Error = NetworkError.unknown(0)
    
    var dtoToReturn = BannerDto(
        imagen64: "data:image/png;base64,dGVzdA==",
        url: "https://www.sri.gob.ec",
        predeterminado: true
    )
    
    func obtenerBanner() async throws -> BannerDto {
        obtenerBannerWasCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return dtoToReturn
    }
}
