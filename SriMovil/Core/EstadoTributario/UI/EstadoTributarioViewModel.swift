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
    var estadoTributario: EstadoTributarioModel?
    
    // Estado para manejar errores
    var errores: String?
    
    private let useCase: ObtenerInfoEstadoTributarioUseCaseProtocol
    
    init(useCase: ObtenerInfoEstadoTributarioUseCaseProtocol = ObtenerInfoEstadoTributarioUseCase()) {
        self.useCase = useCase
    }
    
    // Función pública para obtener el estado tributario cuando se presiona el botón
    @MainActor
    func obtenerEstadoTributario(ruc: String) async {
        do {
            estadoTributario = try await useCase.execute(ruc: ruc)
            errores = nil // Limpiamos cualquier error anterior si la llamada es exitosa
        } catch {
            estadoTributario = nil // En caso de error, limpiamos el estado
            errores = "Error al obtener el estado tributario: \(error.localizedDescription)" // Corregimos el error de mutabilidad
            print(error)
            
        }
    }
}
