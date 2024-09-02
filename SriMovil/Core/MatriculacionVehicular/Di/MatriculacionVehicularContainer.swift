//
//  Container.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation
import Factory

extension Container {
    
    // Network
    var vehiculosApi: Factory<VehiculosApiType> {
        self { VehiculosApi() }.singleton
    }
    
    // DataSources
    var vehiculosRemoteDataSource: Factory<VehiculosRemoteDataSourceType> {
        self { VehiculosRemoteDataSource() }.singleton
    }
    var errorMapper: Factory<InfoVehiculoDomainErrorMapper> {
        self { InfoVehiculoDomainErrorMapper() }.singleton
    }
    
    // Repositories
    var obtenerInfoVehiculoRepository: Factory<ObtenerInfoVehiculoRepositoryType> {
        self { ObtenerInfoVehiculoRepository() }.singleton
    }
    
    // UseCases
    var obtenerInfoVehiculoUseCase: Factory<ObtenerInfoVehiculoUseCaseType> {
        self { ObtenerInfoVehiculoUseCase() }.singleton
    }
    
    
    // ViewModels
    var matriculacionVehicularViewModel: Factory<MatriculacionVehicularViewModel> {
        self { MatriculacionVehicularViewModel() }
    }
}
