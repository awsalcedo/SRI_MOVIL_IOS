//
//  EstadoTributarioViewModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import SwiftUI

@Observable
final class EstadoTributarioViewModel {
    
    // Estado que se actualizará en la UI
    var estadoTributarioState: ViewStates<EstadoTributarioModel?> = .idle
    
    private let useCase: ObtenerInfoEstadoTributarioUseCaseProtocol
    
    init(useCase: ObtenerInfoEstadoTributarioUseCaseProtocol = ObtenerInfoEstadoTributarioUseCase()) {
        self.useCase = useCase
    }
    
    @MainActor
    func obtenerEstadoTributario(ruc: String) async {
        Task {
            estadoTributarioState = .loading
            do {
                let estadoTributario = try await useCase.execute(ruc: ruc)
                estadoTributarioState = .success(estadoTributario)
                
            } /*catch {
               estadoTributarioState = .failure("Error al obtener el estado tributario: \(error.localizedDescription)")
               }*/
            catch let error as SriNetworkError {
                // Asignar el mensaje de error específico de SriNetworkError
                estadoTributarioState = .failure(error.descripcion)
            } catch {
                // Si por alguna razón es un error desconocido
                estadoTributarioState = .failure("Error desconocido: \(error.localizedDescription)")
            }
        }
    }
}
