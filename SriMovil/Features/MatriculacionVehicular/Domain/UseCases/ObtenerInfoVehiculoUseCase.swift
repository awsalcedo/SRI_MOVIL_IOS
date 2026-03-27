//
//  ObtenerInfoVehiculoUseCase.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

/*
 Para no inyectar una implementación concreta al viewModel y facilitar los test de forma aislada, sino estamos acoplados con el usecase.
 
 Esta abstracción (protocol) se debe crear donde está el useCase, si se lo crea en la capa de UI, el usecase tendría que acceder a esta capa para poder implementar el protocol, por tanto tiene que crearse donde está el useCase.
 */

protocol ObtenerInfoVehiculoUseCaseProtocol {
    func execute(idVehiculo: String) async throws -> InfoVehiculoModel
}

struct ObtenerInfoVehiculoUseCase: ObtenerInfoVehiculoUseCaseProtocol {
    
    private let repository: ObtenerInfoVehiculoRepositoryProtocol
    
    init(repository: ObtenerInfoVehiculoRepositoryProtocol = ObtenerInfoVehiculoRepository(remoteDataSource: VehiculosRemoteDataSource(api: VehiculosApi()))) {
        self.repository = repository
    }
    
    
    /*
     No es necesario verificar el resultado de nuevo en el caso de uso, ya que el repositorio ya maneja el mapeo de errores. Podemos retornar directamente el resultado del repositorio.
     
     Separación de Responsabilidades: El caso de uso solo debe orquestar la llamada al repositorio. La lógica de negocio y manejo de errores específicos de dominio ya está bien encapsulada en el repositorio y el mapper de errores.
     
     */
    
    /// Ejecuta el caso de uso para obtener la información del vehículo.
    ///
    /// - Parameter idVehiculo: La placa, RAMV o CPN del vehículo.
    /// - Returns: El modelo de información del vehículo.
    
    func execute(idVehiculo: String) async throws -> InfoVehiculoModel {
        return try await repository.obtenerInfoVehiculo(idVehiculo: idVehiculo)
    }
}
