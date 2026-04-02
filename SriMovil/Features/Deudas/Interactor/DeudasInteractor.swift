//
//  DeudasInteractor.swift
//  SriMovil
//
//  Created by usradmin on 30/3/26.
//

import Foundation

final class DeudasInteractor: DeudasInteractoProtocol {
    
    // MARK: - Private Properties
    
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Initializers
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Functions
    
    func consultarPorNombre(nombre: String, tipoPersona: String, resultados: Int) async throws -> DeudasModel {
        let endPoint = API.Endpoints.deudasPorNombre(nombre: nombre, tipoPersona: tipoPersona, resultados: resultados)
        let dto: DeudasDTO = try await networkService.get(endpoint: endPoint)
        return dto.toDomain()
    }
    
    func consultarPorIdentificacion(identificacion: String, tipoPersona: String) async throws -> DeudasModel {
        let endPoint = API.Endpoints.deudasPorIdentificacion(identificacion: identificacion, tipoPersona: tipoPersona)
        let dto: DeudasDTO = try await networkService.get(endpoint: endPoint)
        return dto.toDomain()
    }
}
