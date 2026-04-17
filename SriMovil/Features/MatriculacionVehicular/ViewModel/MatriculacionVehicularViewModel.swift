//
//  MatriculacionVehicularViewModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI
import Observation
import os

@Observable
@MainActor
final class MatriculacionVehicularViewModel: MatriculacionVehicularViewModelProtocol {
    
    // MARK: - Propiedades Privadas
    
    @ObservationIgnored
    private let interactor: MatriculacionVehicularInteractorProtocol
    
    // MARK: - Propiedades
    
    var state: ViewState<InfoVehiculoModel> = .idle
    
    // MARK: - Inicializadores
    
    init(interactor: MatriculacionVehicularInteractorProtocol = MatriculacionVehicularInteractor()
    ) {
        self.interactor = interactor
    }
    
    // MARK: - Funciones

    func obtenerInfoVehiculo(idVehiculo: String) async {
        
        let idVehiculoLimpio = idVehiculo.trimmingCharacters(in: .whitespacesAndNewlines)
        
        state = .loading
        
        do {
            let infoVehiculo = try await interactor.obtenerInfoVehiculo(idVehiculo: idVehiculoLimpio)
            state = .success(infoVehiculo)
        } catch {
            state = mapErrorToState(error)
        }
        
    }
    
    func resetState() {
        state = .idle
    }
    
    // MARK: - Funciones Privadas
    
    private func mapErrorToState(_ error: Error) -> ViewState<InfoVehiculoModel> {
        
        if let networkError = error as? NetworkError {
            Logger.matriculacion.error("NetworkError: \(networkError, privacy: .private)")
            
            switch networkError {
            case .unauthorized:
                return .failure(
                    message: AppStrings.Error.unauthorized,
                    isInlineFieldError: false
                )
        
            case .serverError:
                return .failure(
                    message: AppStrings.Error.server,
                    isInlineFieldError: false)
                
            case .notFound(let message):
                return .failure(
                    message: message ?? AppStrings.Error.notFound,
                    isInlineFieldError: true)
                
            case .invalidURL,
                    .invalidResponse,
                    .badRequest,
                    .validateError,
                    .notAcceptable,
                    .unknown:
                return .failure(
                    message: AppStrings.Error.generic,
                    isInlineFieldError: false
                )

            }
            
        } else if let urlError = error as? URLError {
            Logger.matriculacion.error("URLError: \(urlError.code.rawValue, privacy: .public)")
            
            switch urlError.code {
            case .notConnectedToInternet:
                return .failure(
                    message: AppStrings.Error.network,
                    isInlineFieldError: false
                )
                
            case .timedOut:
                return .failure(
                    message: AppStrings.Error.timeout,
                    isInlineFieldError: false
                )
            
            case .cancelled:
                return .idle
                
            default:
                return .failure(
                    message: AppStrings.Error.generic,
                    isInlineFieldError: false
                )
            }
            
        } else {
            Logger.matriculacion.error("Unknown error: \(error.localizedDescription, privacy: .private)")
            return .failure(
                message: AppStrings.Error.generic,
                isInlineFieldError: false
            )
        }
        
    }
}
