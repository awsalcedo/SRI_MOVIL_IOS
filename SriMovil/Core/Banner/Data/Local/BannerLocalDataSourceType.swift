//
//  BannerLocalDataSourceType.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 16/8/24.
//

import Foundation

protocol BannerLocalDataSourceType {
    func guardarBanner(banner: BannerModel) throws
    func obtenerBanner() throws -> BannerModel?
}
