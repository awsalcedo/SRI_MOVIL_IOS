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
    @Injected(\.obtenerInfoVehiculoRepository) var repository
    
    /*func execute(idVehiculo: String) async -> Result<InfoVehiculoModel, InfoVehiculoDomainError> {
     let result = await repository.obtenerInfoVehiculo(idVehiculo: idVehiculo)
     
     // Verificar si ha sido exitoso o ha fallado
     switch result {
     case .success(let infoVehiculo):
     return .success(infoVehiculo)
     case .failure(let error):
     return .failure(error)
     }
     }*/
    
    /*  
        No es necesario verificar el resultado de nuevo en el caso de uso, ya que el repositorio ya maneja el mapeo de errores. Podemos retornar directamente el resultado del repositorio.
     
        Separación de Responsabilidades: El caso de uso solo debe orquestar la llamada al repositorio. La lógica de negocio y manejo de errores específicos de dominio ya está bien encapsulada en el repositorio y el mapper de errores.
     
        Inyección de Dependencias: La inyección de dependencias mediante el uso de Factory asegura que los componentes sean fácilmente intercambiables y testeables.
     */
    
    /// Ejecuta el caso de uso para obtener la información del vehículo.
    ///
    /// - Parameter idVehiculo: La placa, RAMV o CPN del vehículo.
    /// - Returns: Un resultado que contiene el modelo de información del vehículo o un error de dominio.
    
    func execute(idVehiculo: String) async -> Result<InfoVehiculoModel, InfoVehiculoDomainError> {
        return await repository.obtenerInfoVehiculo(idVehiculo: idVehiculo)
    }
}
