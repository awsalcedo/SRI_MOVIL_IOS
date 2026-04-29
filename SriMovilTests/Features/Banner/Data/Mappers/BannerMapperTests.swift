//
//  BannerMapperTests.swift
//  SriMovilTests
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 29/4/26.
//

import Testing
@testable import SriMovil

@Suite("BannerMapper Tests")
struct BannerMapperTests {
    
    // MARK: - roDomain Tests
    
    @Test("toDomain maps all fields from BannerDto to BannerModel")
    func toDomainMapsAllFields() {
        // Given
        let dto = BannerDto(
            imagen64: "data:image/png;base64,dGVzdA==",
            url: "www.sri.gob.ec",
            predeterminado: true
        )
        
        // When
        let model = BannerMapper.toDomain(dto)
        
        // Then
        #expect(model.imagen64 == dto.imagen64)
        #expect(model.url == dto.url)
        #expect(model.predeterminado == dto.predeterminado)
    }
    
    @Test("toDomain keeps predeterminado as false")
    func toDomainKeepsPredeterminadoFalse() {
        // Given
        let dto = BannerDto(
            imagen64: "data:image/png;base64,dGVzdA==",
            url: "www.sri.gob.ec",
            predeterminado: true
        )
        
        // When
        let model = BannerMapper.toDomain(dto)
        
        // Then
        #expect(model.predeterminado == false)
    }
}

