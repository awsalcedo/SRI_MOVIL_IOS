//
//  MatriculacionVehicularViewModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

@Observable
final class MatriculacionVehicularViewModel: ObservableObject {
    
    // Estado que se actualizará en la UI
    var vehiculoState: ViewStates<InfoVehiculoModel> = .idle
    
    private let useCase: ObtenerInfoVehiculoUseCaseProtocol
    
    init(useCase: ObtenerInfoVehiculoUseCaseProtocol = ObtenerInfoVehiculoUseCase()) {
        self.useCase = useCase
    }
    
    @MainActor
    func obtenerInfoVehiculo(idVehiculo: String) async {
        
        Task {
            vehiculoState =  .loading
            do {
                let infoVehiculo = try await useCase.execute(idVehiculo: idVehiculo)
                vehiculoState = .success(infoVehiculo)
            } catch let error as SriNetworkError {
                // Asignar el mensaje de error específico de SriNetworkError
                vehiculoState = .failure(error.descripcion)
            } catch {
                // Si por alguna razón es un error desconocido
                vehiculoState = .failure("Error desconocido: \(error.localizedDescription)")
            }
        }
    }
}
