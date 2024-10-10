//
//  MatriculacionVehicularViewModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI
import Factory

class MatriculacionVehicularViewModel: ObservableObject {
    
    @Injected(\.obtenerInfoVehiculoUseCase) private var useCase
    
    // Estados de la vista
    @Published var estado: Estado = .inicial
    
    enum Estado {
        case inicial
        case cargando
        case cargado(InfoVehiculoModel)
        case error(InfoVehiculoDomainError)
    }
    
    // Función para obtener información del vehículo
    func obtenerInfoVehiculo(idVehiculo: String) async {
        estado = .cargando
        
        let resultado = await useCase.execute(idVehiculo: idVehiculo)
        DispatchQueue.main.async {
            switch resultado {
            case .success(let info):
                //self.estado = .cargado(info)
                print("se obtuvo la información")
            case .failure(let error):
                //self.estado = .error(error)
                print("se obtuvo la información")
            }
        }
    }
    
}
