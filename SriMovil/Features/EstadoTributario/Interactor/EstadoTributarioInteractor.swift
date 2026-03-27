//
//  EstadoTributarioInteractor.swift
//  SriMovil
//
//  Created by usradmin on 26/3/26.
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
        let endPoint = API.Endpoints.estadoTributario(ruc: ruc)
        let dto: EstadoTributarioDTO = try await networkService.get(endpoint: endPoint)
        return dto.toDomain()
    }
}
