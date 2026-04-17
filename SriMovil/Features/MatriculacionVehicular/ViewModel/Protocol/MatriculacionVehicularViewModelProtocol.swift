//
//  MatriculacionVehicularViewModelProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 16/4/26.
//

import Foundation

@MainActor
protocol MatriculacionVehicularViewModelProtocol: Observable {
    
    // MARK: - Popiedades
    
    var state: ViewState<InfoVehiculoModel> { get set }
    
    // MARK: - Funciones
    
    func obtenerInfoVehiculo(idVehiculo: String) async
}
