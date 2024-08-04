//
//  VehiculosApi.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation
import Factory

class VehiculosApi: VehiculosApiType {
  
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

extension HTTPMethod {
    var rawValue: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}
