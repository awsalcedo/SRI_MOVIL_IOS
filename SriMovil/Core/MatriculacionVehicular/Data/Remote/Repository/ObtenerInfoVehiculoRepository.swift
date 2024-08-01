//
//  ObtenerInfoVehiculoRepository.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation
import Factory

class ObtenerInfoVehiculoRepository: ObtenerInfoVehiculoRepositoryType {
    @Injected(\.vehiculosRemoteDataSource) var remoteDataSource//: VehiculosRemoteDataSourceType
    @Injected(\.errorMapper) var errorMapper//: InfoVehiculoDomainErrorMapper
    
    func obtenerInfoVehiculo(idVehiculo: String) async -> Result<InfoVehiculoModel, InfoVehiculoDomainError> {
        // Obtén el resultado del remoteDataSource
        let result: Result<InfoVehiculoDto, HttpClientError> = await remoteDataSource.obtenerInfoVehiculo(idVehiculo: idVehiculo)
        
        // Maneja el resultado
        switch result {
        case .success(let infoVehiculoDto):
            // Transforma el DTO a tu modelo de dominio
            let infoVehiculoModel = InfoVehiculoModel(from: infoVehiculoDto)
            return .success(infoVehiculoModel)
        case .failure(let error):
            // Mapea el error a tu tipo de error de dominio
            let domainError = errorMapper.map(error: error)
            return .failure(domainError)
        }
    }
}
