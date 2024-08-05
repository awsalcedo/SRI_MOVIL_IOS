//
//  VehiculosRemoteDataSourceType.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

protocol VehiculosRemoteDataSourceType {
    func obtenerInfoVehiculo(idVehiculo: String) async -> Result<InfoVehiculoModel, HttpClientError>
}
