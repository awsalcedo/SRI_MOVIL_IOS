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
    private let useCaseRucValidator: RucValidatorProtocol
    
    init(
        useCase: ObtenerInfoEstadoTributarioUseCaseProtocol = ObtenerInfoEstadoTributarioUseCase(),
        useCaseRucValidator: RucValidatorProtocol = RucValidator()
    ) {
        self.useCase = useCase
        self.useCaseRucValidator = useCaseRucValidator
    }
    
    @MainActor
    func obtenerEstadoTributario(ruc: String) async {
        
        guard useCaseRucValidator.validarRuc(ruc) else {
            estadoTributarioState = .failure("El RUC ingresado debe ser numérico y debe tener 13 dígitos.")
            return
        }
        
        Task {
            estadoTributarioState = .loading
            do {
                let estadoTributario = try await useCase.execute(ruc: ruc)
                estadoTributarioState = .success(estadoTributario)
                
            }
            catch let error as SriNetworkError {
                // Asignar el mensaje de error específico de SriNetworkError
                estadoTributarioState = .failure(error.descripcion)
            } catch {
                // Si por alguna razón es un error desconocido
                estadoTributarioState = .failure("Error desconocido: \(error.localizedDescription)")
            }
        }
    }
    
    func resetState() {
        estadoTributarioState = .idle  // Reinicia el estado a idle
    }
}
