//
//  EstadoTributarioViewModelProtocol.swift
//  SriMovil
//
//  Created by usradmin on 26/3/26.
//

import Foundation

@MainActor
protocol EstadoTributarioViewModelProtocol: Observable {
    
    // MARK: - Properties
    
    var estadoTributario: EstadoTributarioModel? {get}
    var isLoading: Bool {get}
    var errorMessage: String? {get}
    
    // MARK: - Functions
    
    func obtenerEstadoTributario(ruc: String) async
}
