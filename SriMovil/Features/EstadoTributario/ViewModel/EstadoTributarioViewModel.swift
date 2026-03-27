//
//  EstadoTributarioViewModel.swift
//  SriMovil
//
//  Created by usradmin on 26/3/26.
//

import Foundation
import Observation
import os

@Observable
@MainActor
final class EstadoTributarioViewModel: EstadoTributarioViewModelProtocol {
    
    // MARK: - Private Properties
    
    @ObservationIgnored
    private let interactor: EstadoTributarioInteractorProtocol
    
    @ObservationIgnored
    private let rucValidator: RucValidatorProtocol
    
    // MARK: - Properties
    
    var estadoTributario: EstadoTributarioModel?
    var isLoading = false
    var errorMessage: String?
    var isInlineFieldError = false
    
    
    // MARK: Initializers
    
    init(
        interactor: EstadoTributarioInteractorProtocol = EstadoTributarioInteractor(),
        rucValidator: RucValidatorProtocol = RucValidator()
    ) {
        self.interactor = interactor
        self.rucValidator = rucValidator
    }
    
    // MARK: Functions
    
    func obtenerEstadoTributario(ruc: String) async {
        let rucLimpio = ruc.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard rucValidator.validarRuc(rucLimpio) else {
            estadoTributario = nil
            errorMessage = AppStrings.EstadoTributario.invalidRuc
            isInlineFieldError = true
            return
        }
        
        guard !isLoading else { return}
        
        isLoading = true
        estadoTributario = nil
        errorMessage = nil
        isInlineFieldError = false
        
        defer {
            isLoading = false
        }
        
        do {
            let response = try await interactor.obtenerEstadoTributario(ruc: rucLimpio)
            estadoTributario = response
        } catch {
            handleError(error)
        }
    }
    
    func resetState() {
        estadoTributario = nil
        errorMessage = nil
        isLoading = false
        isInlineFieldError = false
    }
    
    // MARK: - Private Functions
    
    private func handleError(_ error: Error) {
        if let networkError = error as? NetworkError {
            Logger.estadoTributario.error("NetworkError: \(networkError, privacy: .private)")
            
            switch networkError {
            case .unauthorized:
                errorMessage = AppStrings.Error.unauthorized
                isInlineFieldError = false
            case .serverError:
                errorMessage = AppStrings.Error.server
                isInlineFieldError = false
            case .notFound(let message):
                errorMessage = message ?? AppStrings.Error.notFound
                isInlineFieldError = true
            case .invalidURL,
                    .invalidResponse,
                    .badRequest,
                    .validateError,
                    .notAcceptable,
                    .unknown:
                errorMessage = AppStrings.Error.generic
                isInlineFieldError = false
            }
            
        } else if let urlError = error as? URLError {
            Logger.estadoTributario.error("URLError: \(urlError.code.rawValue, privacy: .public)")
            
            switch urlError.code {
            case .notConnectedToInternet:
                errorMessage = AppStrings.Error.network
            case .timedOut:
                errorMessage = AppStrings.Error.timeout
            case .cancelled:
                return
            default:
                errorMessage = AppStrings.Error.generic
            }
            
            isInlineFieldError = false
            
        } else {
            Logger.estadoTributario.error("Unknown error: \(error.localizedDescription, privacy: .private)")
            errorMessage = AppStrings.Error.generic
            isInlineFieldError = false
        }
    }
}
