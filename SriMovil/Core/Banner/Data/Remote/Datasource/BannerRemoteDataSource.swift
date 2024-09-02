//
//  BannerRemoteDataSource.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation
import Factory

class BannerRemoteDataSource: BannerRemoteDataSourceType {
    
    @Injected(\.bannerApi) private var api
    
    func obtenerBanner() async -> Result<BannerModel, HttpClientError> {
        let endPoint = EndPoint(
            path: "v1.0/banner",
            queryParameters: nil,
            bodyParameters: nil,
            method: .get)
        
        let result = await api.makeRequest(endPoint: endPoint)
        
        switch result {
        case .success(let data):
            do {
                let bannerDto = try JSONDecoder().decode(BannerDto.self, from: data)
                let bannerModel = BannerModel(toDomain: bannerDto)
                return .success(bannerModel)
            } catch {
                return .failure(.decodingError(error))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
