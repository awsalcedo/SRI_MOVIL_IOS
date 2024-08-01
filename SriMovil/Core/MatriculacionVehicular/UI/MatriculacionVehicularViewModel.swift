//
//  MatriculacionVehicularViewModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI
import Factory

class MatriculacionVehicularViewModel: ObservableObject {
    
    @Injected(\.obtenerInfoVehiculoUseCase) private var useCase: ObtenerInfoVehiculoUseCaseType
    
    // Estados de la vista
    @Published var estado: Estado<InfoVehiculoModel> = .inicial
    var infoVehiculo: InfoVehiculoModel?
    
    enum Estado<Result> {
        case inicial
        case cargando
        case cargado(Result)
        case error(String)
    }
    
    // Función para obtener información del vehículo
    func obtenerInfoVehiculo(idVehiculo: String) async {
        estado = .cargando
        // Llama a la función async para obtener la información del vehículo
        /*Task {
            let resultado = await useCase.execute(idVehiculo: idVehiculo)
            
            // Actualiza el estado y los datos en el hilo principal
            DispatchQueue.main.async {
                switch resultado {
                case .success(let info):
                    self.estado = .cargado(info)
                case .failure(let error):
                    self.estado = .error(error.localizedDescription)
                }
            }
        }*/
        let resultado = await useCase.execute(idVehiculo: idVehiculo)
        DispatchQueue.main.async {
                    switch resultado {
                    case .success(let info):
                        self.infoVehiculo = info
                        self.estado = .cargado(info)
                    case .failure(let error):
                        self.estado = .error(error.localizedDescription)
                    }
                }
    }
    
    // Función para resetear el estado a inicial
    func reset() {
        self.estado = .inicial
    }
    
}
