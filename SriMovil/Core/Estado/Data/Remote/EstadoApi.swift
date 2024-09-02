//
//  EstadoApi.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation
import Factory

class EstadoApi: EstadoApiType {
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
