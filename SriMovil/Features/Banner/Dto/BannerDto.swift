//
//  BannerDTO.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 21/4/26.
//

import Foundation

struct BannerDto: Decodable, Sendable {
    let imagen64: String
    let url: String
    let predeterminado: Bool
}

extension BannerDto {
    func toDomain() -> BannerModel {
        BannerModel(
            imagen64: imagen64,
            url: url,
            predeterminado: predeterminado
        )
    }
}
