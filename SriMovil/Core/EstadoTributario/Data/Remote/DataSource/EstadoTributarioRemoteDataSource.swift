//
//  EstadoTributarioRemoteDataSource.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

struct EstadoTributarioRemoteDataSource: EstadoTributarioRemoteDataSourceProtocol {
    
    private let api: EstadoTributarioApiProtocol
    
    init(api: EstadoTributarioApiProtocol) {
        self.api = api
    }
    
    func obtenerEstadoTributarioRemote(ruc: String) async throws -> EstadoTributarioModel {
        
        let endPoint = EndPoint(
            path: "v1.0/estadoTributario/\(ruc)",
            queryParameters: nil,
            bodyParameters: nil,
            method: .get
        )
        
        let estadoTributarioDTO = try await api.makeRequest(endPoint: endPoint)
        
        return estadoTributarioDTO.toDomain
        
    }
    
    
}
