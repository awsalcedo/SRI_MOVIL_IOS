//
//  EstadoRemoteDataSource.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation
import Factory

class EstadoRemoteDataSource: EstadoRemoteDataSourceType {
    
    @Injected(\.estadoApi) private var api
    
    func obtenerEstado() async -> Result<EstadoDto, HttpClientError> {
        let endPoint = EndPoint(
            path: "v1.0/estado",
            queryParameters: nil,
            bodyParameters: nil,
            method: .get
        )
        
        let result = await api.makeRequest(endPoint: endPoint)
        
        switch result {
        case .success(let data):
            do {
                let estadoDto = try JSONDecoder().decode(EstadoDto.self, from: data)
                return .success(estadoDto)
            } catch {
                return .failure(.decodingError(error))  // Manejar error de decodificación
            }
        case .failure(let error):
            return .failure(error)  // Retornar el error de la solicitud HTTP
        }
    }
}
