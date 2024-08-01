//
//  ObtenerInfoVehiculoRepositoryType.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

// Define un protocolo para el repositorio que obtiene la información del vehículo
protocol ObtenerInfoVehiculoRepositoryType {
    func obtenerInfoVehiculo(idVehiculo: String) async -> Result<InfoVehiculoModel, InfoVehiculoDomainError>
}
