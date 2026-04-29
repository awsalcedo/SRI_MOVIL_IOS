//
//  BannerModelTests.swift
//  SriMovilTests
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 29/4/26.
//

import Foundation
import Testing
@testable import SriMovil

@Suite("BannerModel Tests")
struct BannerModelTests {
    
    // MARK: - destinationUrl Tests
    
    @Test("destinationUrl returns URL when string is valid")
    func destinationUrlReturnWhenStringIsValid() throws {
        
        // Given
        let banner = BannerModel(
            imagen64: "data:image/png;base64,dGVzdA==",
            url: "https://www.sri.gob.ec",
            predeterminado: true
        )
        
        // When
        let url = try #require(banner.destinationUrl)
        
        // Then
        #expect(url.absoluteString == "https://www.sri.gob.ec")
    }
    
    @Test("destinationUrl returns nil when string is empty")
    func destinationUrlReturnsNilWhenStringIsEmpty() {
        
        // Given
        let banner = BannerModel(
            imagen64: "data:image/png;base64,dGVzdA==",
            url: "",
            predeterminado: true
        )
        
        // When
        let url = banner.destinationUrl
        
        // Then
        #expect(url == nil)
    }
    
    @Test("imageData decodes valid Data URL")
    func imageDataDecodesValidDataURL() throws {
        // Given
        let expectedText = "test"
        let base64 = Data(expectedText.utf8).base64EncodedString()
        
        let banner = BannerModel(
            imagen64: "data:image/png;base64,\(base64)",
            url: "https://www.sri.gob.ec",
            predeterminado: true
        )
        
        // When
        let imageData = try #require(banner.imageData)
        let decodedText = String(data: imageData, encoding: .utf8)
        
        // Then
        #expect(decodedText == expectedText)
    }
    
    @Test("imageData returns nil when base64 prefix is missing")
    func imageDataReturnsNilWhenBase64PrefixIsMissing() {
        // Given
        let banner = BannerModel(
            imagen64: "dGVzdA==",
            url: "https://www.sri.gob.ec",
            predeterminado: true
        )
        
        // When
        let imageData = banner.imageData
        
        // Then
        #expect(imageData == nil)
    }
    
    @Test("imageData returns nil when base64 payload is invalid")
    func imageDataReturnsNilWhenBase64PayloadIsInvalid() {
        // Given
        let banner = BannerModel(
            imagen64: "data:image/png;base64,invalid_base64",
            url: "https://www.sri.gob.ec",
            predeterminado: true
        )
        
        // When
        let imageData = banner.imageData
        
        // Then
        #expect(imageData == nil)
    }
}
