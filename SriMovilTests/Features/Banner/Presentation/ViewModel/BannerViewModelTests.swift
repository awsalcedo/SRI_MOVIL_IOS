//
//  BannerViewModelTests.swift
//  SriMovilTests
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 4/5/26.
//

import Foundation
import Testing
@testable import SriMovil

@Suite("BannerViewModel Tests")
@MainActor
struct BannerViewModelTests {
    
    // MARK: - Subject Under Test
    
    private let sut: BannerViewModel
    
    // MARK: - Mocks
    
    private let useCase: MockObtenerBannerUseCase
    
    // MARK: - Initializers
    
    init() {
        useCase = MockObtenerBannerUseCase()
        sut = BannerViewModel(obtenerBannerUseCase: useCase)
    }
    
    // MARK: - Initial State Tests
    
    @Test("initial state is idle")
    func initialStateIsIdle() {
        // Then
        guard case .idle = sut.state else {
            Issue.record("Expected initial state to be idle")
            return
        }
    }
    
    // MARK: - obtenerBanner Tests
    
    @Test("obtenerBanner sets success state when use case succeeds")
    func obtenerBannerSetsSuccessStateWhenUseCaseSucceeds() async {
        // Given
        let expectedBanner = BannerModel(
            imagen64: "data:image/png;base64,dGVzdA==",
            url: "https://www.sri.gob.ec",
            predeterminado: true
        )
        useCase.bannerToReturn = expectedBanner
        
        // When
        await sut.obtenerBanner()
        
        // Then
        #expect(useCase.executeWasCalled)
        
        guard case .success(let banner) = sut.state else {
            Issue.record("Expected state to be success")
            return
        }
        
        #expect(banner == expectedBanner)
    }
    
    @Test("obtenerBanner sets failure state when use case throws unauthorized")
    func obtenerBannerSetsFailureStateWhenUseCaseThrowsUnauthorized() async {
        // Given
        useCase.shouldThrowError = true
        useCase.errorToThrow = NetworkError.unauthorized()
        
        // When
        await sut.obtenerBanner()
        
        // Then
        #expect(useCase.executeWasCalled)
        
        guard case .failure(let message, let isInlineFieldError) = sut.state else {
            Issue.record("Expected state to be failure")
            return
        }
        
        #expect(message == AppStrings.Error.unauthorized)
        #expect(isInlineFieldError == false)
    }
    
    @Test("obtenerBanner sets idle state when use case throws cancelled URL error")
    func obtenerBannerSetsIdleStateWhenUseCaseThrowsCancelledURLError() async {
        // Given
        useCase.shouldThrowError = true
        useCase.errorToThrow = URLError(.cancelled)
        
        // When
        await sut.obtenerBanner()
        
        // Then
        #expect(useCase.executeWasCalled)
        
        guard case .idle = sut.state else {
            Issue.record("Expected state to be idle")
            return
        }
    }
    
    @Test("resetState sets state to idle")
    func resetStateSetsStateToIdle() {
        // Given
        sut.state = .success(
            BannerModel(
                imagen64: "data:image/png;base64,dGVzdA==",
                url: "https://www.sri.gob.ec",
                predeterminado: true
            )
        )
        
        // When
        sut.resetState()
        
        // Then
        guard case .idle = sut.state else {
            Issue.record("Expected state to be idle")
            return
        }
    }
}

// MARK: - Mock Use Case

private final class MockObtenerBannerUseCase: ObtenerBannerUseCaseProtocol, @unchecked Sendable {
    
    var executeWasCalled = false
    var shouldThrowError = false
    var errorToThrow: Error = NetworkError.unknown(0)
    
    var bannerToReturn = BannerModel(
        imagen64: "data:image/png;base64,dGVzdA==",
        url: "https://www.sri.gob.ec",
        predeterminado: true
    )
    
    func execute() async throws -> BannerModel {
        executeWasCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return bannerToReturn
    }
}
