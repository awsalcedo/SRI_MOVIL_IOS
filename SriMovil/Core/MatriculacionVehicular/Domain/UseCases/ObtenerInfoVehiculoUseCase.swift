//
//  ObtenerInfoVehiculoUseCase.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation
import Factory

/*
 Para no inyectar una implementación concreta al viewModel y facilitar los test de forma aislada, sino estamos acoplados con el usecase.
 
 Esta abstracción (protocol) se debe crear donde está el useCase, si se lo crea en la capa de UI, el usecase tendría que acceder a esta capa para poder implementar el protocol, por tanto tiene que crearse donde está el useCase.
 */

protocol ObtenerInfoVehiculoUseCaseType {
    func execute(idVehiculo: String) async -> Result<InfoVehiculoModel, InfoVehiculoDomainError>
}

class ObtenerInfoVehiculoUseCase: ObtenerInfoVehiculoUseCaseType {
    @Injected(\.obtenerInfoVehiculoRepository) var repository//: ObtenerInfoVehiculoRepositoryType
    
    
    func execute(idVehiculo: String) async -> Result<InfoVehiculoModel, InfoVehiculoDomainError> {
        let result = await repository.obtenerInfoVehiculo(idVehiculo: idVehiculo)
        
        // Verificar si ha sido exitoso o ha fallado
        switch result {
        case .success(let infoVehiculo):
            return .success(infoVehiculo)
        case .failure(let error):
            return .failure(error)
        }
    }
}
