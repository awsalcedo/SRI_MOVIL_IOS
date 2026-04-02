//
//  DeudasViewModelProtocol.swift
//  SriMovil
//
//  Created by usradmin on 30/3/26.
//

import Foundation

@MainActor
protocol DeudasViewModelProtocol: Observable {
    
    // MARK: Properties
    
    var deudas: DeudasModel? {get}
    var isLoading: Bool {get}
    var errorMessage: String? {get}
    
    // MARK: - Functions
    
    func obtenerDeudas(
        tipoContribuyente: String,
        tipoDocumento: String,
        numeroDocumento: String?,
        apellidos: String?,
        nombres: String?
    ) async
}
