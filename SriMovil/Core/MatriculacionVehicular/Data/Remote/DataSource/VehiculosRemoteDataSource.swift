//
//  VehiculosRemoteDataSource.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

/// Componente que se encarga de implementar los detalles de infraestructura para realizar las peticiones al Core de servicios del SRIMOVIL

class VehiculosRemoteDataSource: VehiculosRemoteDataSourceProtocol {

    private let api: VehiculosApiProtocol
    
    init(api: VehiculosApiProtocol) {
        self.api = api
    }
    
    func obtenerInfoVehiculo(idVehiculo: String) async throws -> InfoVehiculoModel {
        let endPoint = EndPoint(
            path: "v1.0/matriculacion/valor/\(idVehiculo)",
            queryParameters: nil,
            bodyParameters: nil,
            method: .get
        )
        
        let infoVehiculoDto = try await api.makeRequest(endPoint: endPoint)
        
        return infoVehiculoDto.toDomain
    }
}
