//
//  BannerApi.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation
import Factory

class BannerApi: BannerApiType {
    
    @Injected(\.httpClient) private var httpClient
    
    func makeRequest(endPoint: EndPoint) async -> Result<Data, HttpClientError> {
        let result = await httpClient.makeRequest(endPoint: endPoint)
        
        switch result {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
