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
    
    // MARK: - Funciones
    
    func obtenerInfoVehiculo(idVehiculo: String) async
}
