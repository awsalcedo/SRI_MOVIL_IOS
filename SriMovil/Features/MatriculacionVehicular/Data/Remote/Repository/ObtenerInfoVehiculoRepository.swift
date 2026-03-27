//
//  ObtenerInfoVehiculoRepository.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

class ObtenerInfoVehiculoRepository: ObtenerInfoVehiculoRepositoryProtocol {
    
    private let remoteDataSource: VehiculosRemoteDataSourceProtocol
    
    init(remoteDataSource: VehiculosRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func obtenerInfoVehiculo(idVehiculo: String) async throws -> InfoVehiculoModel {
        return try await remoteDataSource.obtenerInfoVehiculo(idVehiculo: idVehiculo)
    }
}
