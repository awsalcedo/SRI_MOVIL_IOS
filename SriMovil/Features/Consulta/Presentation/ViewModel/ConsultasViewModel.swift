//
//  ConsultasViewModel.swift
//  SriMovil
//
//  Created by usradmin on 5/6/26.
//

import Foundation
import Observation
import os

/// ViewModel responsable de gestionar el estado de la pantalla principal
/// de consultas.
///
/// Su responsabilidad es:
/// - solicitar las opciones de consultas al caso de uso;
/// - exponer el estado observable para SwiftUI;
/// - traducir errores técnicos a mensajes entendibles para el usuario.
///
/// No realiza navegación. La vista decide cómo reaccionar ante las acciones
/// del usuario.
@Observable
@MainActor
final class ConsultasViewModel: ConsultasViewModelProtocol {
    
    // MARK: Propiedades Privadas
    
    @ObservationIgnored
    private let obtenerConsultasUseCase: ObtenerConsultasUseCaseProtocol
    
    // MARK: Propiedades
    
    var state: ViewState<[ConsultaItemModel]> = .idle
    
    // MARK: Inicializadores
    
    init(obtenerConsultasUseCase: ObtenerConsultasUseCaseProtocol = ObtenerConsultasUseCase()) {
        self.obtenerConsultasUseCase = obtenerConsultasUseCase
    }
    
    // MARK: Funciones
    
    func obtenerConsultas() async {
        state = .loading
        
        do {
            let consultas = try await obtenerConsultasUseCase.execute()
            state = .success(consultas)
        } catch {
            state = mapErrorToState(error)
        }
    }
    
    func resetState() {
        state = .idle
    }
    
    // MARK: Funciones Privadas
    
    private func mapErrorToState(_ error: Error) -> ViewState<[ConsultaItemModel]> {
        if let consultasDataError = error as? ConsultasDataError {
            Logger.consultas.error("ConsultasDataError: \(String(describing:consultasDataError), privacy: .private)")
                
            switch consultasDataError {
            case .fileNotFound:
                return .failure(
                    message: AppStrings.Consultas.fileNotFound,
                    isInlineFieldError: false
                )
                    
            case .readFailed:
                return .failure(
                    message: AppStrings.Consultas.readFailed,
                    isInlineFieldError: false
                )
                    
            case .decodingFailed:
                return .failure(
                    message: AppStrings.Consultas.decodingFailed,
                    isInlineFieldError: false
                )
            }
        }
            
        Logger.consultas.error("Unknown error: \(error.localizedDescription, privacy: .private)")
            
        return .failure(
            message: AppStrings.Error.generic,
            isInlineFieldError: false
        )
    }
}
