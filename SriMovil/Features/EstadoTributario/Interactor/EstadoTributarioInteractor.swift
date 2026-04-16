//
//  EstadoTributarioInteractor.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 26/3/26.
//

import Foundation

final class EstadoTributarioInteractor: EstadoTributarioInteractorProtocol {
    
    // MARK: - Private Properties
    
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Initializers
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Functions
    
    func obtenerEstadoTributario(ruc: String) async throws -> EstadoTributarioModel {
        let dto: EstadoTributarioDTO = try await networkService.get(url: .estadoTributario(ruc: ruc))
        return dto.toDomain()
    }
}
