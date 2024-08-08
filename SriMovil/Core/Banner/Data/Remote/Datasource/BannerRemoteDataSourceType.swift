//
//  BannerRemoteDataSourceType.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation

protocol BannerRemoteDataSourceType {
    func obtenerBanner() async -> Result<BannerModel, HttpClientError>
}
