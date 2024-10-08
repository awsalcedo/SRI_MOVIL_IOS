//
//  ObtenerInfoEstadoTributarioUseCase.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

protocol ObtenerInfoEstadoTributarioUseCaseProtocol {
    func execute(ruc: String) async throws -> EstadoTributarioModel
}

class ObtenerInfoEstadoTributarioUseCase: ObtenerInfoEstadoTributarioUseCaseProtocol {
    
    private let repository: EstadoTributarioRepositoryProtocol
    
    init(repository: EstadoTributarioRepositoryProtocol = EstadoTributarioRepository(remoteDataSource: EstadoTributarioRemoteDataSource(api: EstadoTributarioApi()))) {
        self.repository = repository
    }
    
    func execute(ruc: String) async throws -> EstadoTributarioModel {
        return try await repository.obtenerEstadoTributario(ruc: ruc)
    }
    
}
