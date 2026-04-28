//
//  BannerMapper.swift
//  SriMovil
//
//  Created by usradmin on 28/4/26.
//

import Foundation

struct BannerMapper {
    static func toDomain(_ dto: BannerDto) -> BannerModel {
        BannerModel(
            imagen64: dto.imagen64,
            url: dto.url,
            predeterminado: dto.predeterminado
        )
    }
}
