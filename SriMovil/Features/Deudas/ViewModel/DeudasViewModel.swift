//
//  DeudasViewModel.swift
//  SriMovil
//
//  Created by usradmin on 30/3/26.
//

import Foundation
import Observation
import os

@Observable
@MainActor
final class DeudasViewModel: DeudasViewModelProtocol {
    
    // MARK: - Private Properties
    
    @ObservationIgnored
    private let interactor: DeudasInteractoProtocol
    
    @ObservationIgnored
    private let rucValidator: RucValidatorProtocol
    
    // MARK: - Properties
    
    var deudas: DeudasModel?
    var isLoading = false
    var errorMessage: String?
    var isInlineFieldError = false
    
    // MARK: - Initializers
    
    init(
        interactor: DeudasInteractoProtocol = DeudasInteractor(),
        rucValidator: RucValidatorProtocol = RucValidator()
    ) {
        self.interactor = interactor
        self.rucValidator = rucValidator
    }
    
    // MARK: - Functions
    
    func obtenerDeudas(
        tipoContribuyente: String,
        tipoDocumento: String,
        numeroDocumento: String?,
        apellidos: String?,
        nombres: String?
    ) async {
        let tipoContribuyenteLimpio = mapTipoPersona(tipoContribuyente)
        let tipoDocumentoLimpio = tipoDocumento.trimmingCharacters(in: .whitespacesAndNewlines)
        let numeroDocumentoLimpio = numeroDocumento?.trimmingCharacters(in: .whitespacesAndNewlines)
        let apellidosLimpios = apellidos?.trimmingCharacters(in: .whitespacesAndNewlines)
        let nombresLimpios = nombres?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !isLoading else { return }
        
        switch tipoDocumentoLimpio {
        case "Número de RUC":
            guard let ruc = numeroDocumentoLimpio, !ruc.isEmpty else {
                showInlineError(AppStrings.Deudas.emptyRuc)
                return
            }
            
            guard ruc.count == 13 else {
                showInlineError(AppStrings.Deudas.invalidRucLength)
                return
            }
            
            guard rucValidator.validarRuc(ruc) else {
                showInlineError(AppStrings.Deudas.invalidRuc)
                return
            }
            
            await executeRequest {
                try await interactor.consultarPorIdentificacion(
                    identificacion: ruc,
                    tipoPersona: tipoContribuyenteLimpio
                )
            }
            
        case "Número de cédula":
            guard let cedula = numeroDocumentoLimpio, !cedula.isEmpty else {
                showInlineError(AppStrings.Deudas.emptyCedula)
                return
            }
            
            guard cedula.count == 10 else {
                showInlineError(AppStrings.Deudas.invalidCedula)
                return
            }
            
            guard cedula.allSatisfy(\.isNumber) else {
                showInlineError(AppStrings.Deudas.invalidCedula)
                return
            }
            
            await executeRequest {
                try await interactor.consultarPorIdentificacion(
                    identificacion: cedula,
                    tipoPersona: tipoContribuyenteLimpio
                )
            }
            
        case "Apellidos y Nombres":
            guard let apellidos = apellidosLimpios, !apellidos.isEmpty else {
                showInlineError(AppStrings.Deudas.emptyLastName)
                return
            }
            
            let nombreCompleto = [apellidos, nombresLimpios]
                .compactMap { $0 }
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { !$0.isEmpty }
                .joined(separator: " ")
                .uppercased()
            
            await executeRequest {
                try await interactor.consultarPorNombre(
                    nombre: nombreCompleto,
                    tipoPersona: tipoContribuyenteLimpio,
                    resultados: 30
                )
            }
            
        default:
            Logger.deudas.error("Tipo de documento no soportado: \(tipoDocumentoLimpio, privacy: .private)")
            errorMessage = AppStrings.Error.generic
            isInlineFieldError = false
        }
    }
    
    func resetState() {
        deudas = nil
        errorMessage = nil
        isLoading = false
        isInlineFieldError = false
    }
    
    // MARK: - Private Functions
    
    private func executeRequest(_ request: () async throws -> DeudasModel) async {
        isLoading = true
        deudas = nil
        errorMessage = nil
        isInlineFieldError = false
        
        defer {
            isLoading = false
        }
        
        do {
            let response = try await request()
            deudas = response
        } catch {
            handleError(error)
        }
    }
    
    private func showInlineError(_ message: String) {
        deudas = nil
        errorMessage = message
        isInlineFieldError = true
    }
    
    private func handleError(_ error: Error) {
        if let networkError = error as? NetworkError {
            Logger.deudas.error("NetworkError: \(networkError, privacy: .private)")
            
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
            Logger.deudas.error("URLError: \(urlError.code.rawValue, privacy: .public)")
            
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
            Logger.deudas.error("Unknown error: \(error.localizedDescription, privacy: .private)")
            errorMessage = AppStrings.Error.generic
            isInlineFieldError = false
        }
    }
    
    private func mapTipoPersona(_ tipo: String) -> String {
        switch tipo {
        case "Persona Natural":
            return "N"
        case "Sociedades":
            return "J"
        default:
            return "N"
        }
    }
}
