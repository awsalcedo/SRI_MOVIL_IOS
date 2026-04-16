//
//  DeudasInteractor.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 30/3/26.
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
        let dto: DeudasDTO = try await networkService.get(url: .deudasPorNombre(nombre: nombre, tipoPersona: tipoPersona, resultados: resultados))
        return dto.toDomain()
    }
    
    func consultarPorIdentificacion(identificacion: String, tipoPersona: String) async throws -> DeudasModel {
        let dto: DeudasDTO = try await networkService.get(url: .deudasPorIdentificacion(identificacion: identificacion, tipoPersona: tipoPersona))
        return dto.toDomain()
    }
}
