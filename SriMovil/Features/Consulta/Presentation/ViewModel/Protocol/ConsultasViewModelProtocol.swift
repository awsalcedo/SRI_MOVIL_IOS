//
//  ConsultasViewModelProtocol.swift
//  SriMovil
//
//  Created by usradmin on 5/6/26.
//

import Foundation

/// Define el contrato que debe cumplir el ViewModel de la pantalla principal
/// de consultas.
///
/// Este protocolo permite desacoplar la vista de una implementación concreta,
/// facilitando pruebas, previews y futuras sustituciones del ViewModel
@MainActor
protocol ConsultasViewModelProtocol: Observable {
    
    // MARK: Propiedades
    
    /// Estado actual de la pantalla de consultas.
    var state: ViewState<[ConsultaItemModel]> {get set}
    
    // MARK: Funciones
    
    /// Obtiene las opciones disponibles para la pantalla de consultas.
    func obtenerConsultas() async
    
    /// Reinicia el estado del ViewModel a su estado inicial.
    func resetState()
    
}
