//
//  BannerModel.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation

struct BannerModel: Codable, Equatable {
    let imagen64: String
    let url: String
    let predeterminado: Bool
    
    init(toDomain dto: BannerDto) {
        self.imagen64 = dto.imagen64
        self.url = dto.url
        self.predeterminado = dto.predeterminado
    }
}
