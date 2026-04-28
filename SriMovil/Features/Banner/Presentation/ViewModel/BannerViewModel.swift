//
//  BannerViewModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 21/4/26.
//

import Foundation
import Observation
import os

/// ViewModel responsable de gestionar el estado del banner en la pantalla principal de Consultas.
///
/// Su responsabilidad es:
/// - solicitar el banner al interactor;
/// - publicar estados observables para la UI;
/// - traducir errores técnicos a mensajes entendibles para el usuario.
///
/// No realiza navegación.
/// La vista decide cómo reaccionar ante el éxito o interacción del usuario con el banner.
@Observable
@MainActor
final class BannerViewModel: BannerViewModelProtocol {
    
    // MARK: Propiedades Privadas
    
    @ObservationIgnored
    private let obtenerBannerUseCase: ObtenerBannerUseCaseProtocol
    
    // MARK: Propiedades
    
    var state: ViewState<BannerModel> = .idle
    
    // MARK: Inicializadores
    
    init(obtenerBannerUseCase: ObtenerBannerUseCaseProtocol = ObtenerBannerUseCase()) {
        self.obtenerBannerUseCase = obtenerBannerUseCase
    }
    
    // MARK: Funciones
    
    func obtenerBanner() async {
        state = .loading
        
        do {
            let banner = try await obtenerBannerUseCase.execute()
            state = .success(banner)
        } catch {
            state = mapErrorToState(error)
        }
    }
    
    func resetState() {
        state = .idle
    }
    
    // MARK: - Funciones Privadas
    
    private func mapErrorToState(_ error: Error) -> ViewState<BannerModel> {
        
        if let networkError = error as? NetworkError {
            Logger.banner.error("NetworkError: \(networkError, privacy: .private)")
            
            switch networkError {
            case .unauthorized:
                return .failure(
                    message: AppStrings.Error.unauthorized,
                    isInlineFieldError: false
                )
                
            case .serverError:
                return .failure(
                    message: AppStrings.Error.server,
                    isInlineFieldError: false
                )
                
            case .notFound:
                return .failure(
                    message: AppStrings.Error.notFound,
                    isInlineFieldError: false
                )
                
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
            Logger.banner.error("URLError: \(urlError.code.rawValue, privacy: .public)")
            
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
            Logger.banner.error("Unknown error: \(error.localizedDescription, privacy: .private)")
            return .failure(
                message: AppStrings.Error.generic,
                isInlineFieldError: false
            )
        }
    }
    
}
