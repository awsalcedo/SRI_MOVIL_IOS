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
    //var estadoTributario: EstadoTributarioModel?
    
    var estadoTributarioState: ViewStates<EstadoTributarioModel?> = .idle
    
    // Estado para manejar errores
    //var errores: String?
        
    private let useCase: ObtenerInfoEstadoTributarioUseCaseProtocol
    
    init(useCase: ObtenerInfoEstadoTributarioUseCaseProtocol = ObtenerInfoEstadoTributarioUseCase()) {
        self.useCase = useCase
    }
    
    // Función pública para obtener el estado tributario cuando se presiona el botón
    @MainActor
    func obtenerEstadoTributario(ruc: String) async {
        Task {
            estadoTributarioState = .loading
            do {
                let estadoTributario = try await useCase.execute(ruc: ruc)
                estadoTributarioState = .success(estadoTributario)
                
            } catch {
                /*estadoTributario = nil // En caso de error, limpiamos el estado
                errores = "Error al obtener el estado tributario: \(error.localizedDescription)" // Corregimos el error de mutabilidad
                print(error)*/
                estadoTributarioState = .failure("Error al obtener el estado tributario: \(error.localizedDescription)")
                
            }
        }
    }
}
