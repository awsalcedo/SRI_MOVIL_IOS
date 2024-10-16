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

struct ObtenerInfoEstadoTributarioUseCase: ObtenerInfoEstadoTributarioUseCaseProtocol {
    
    private let repository: EstadoTributarioRepositoryProtocol
    
    init(repository: EstadoTributarioRepositoryProtocol = EstadoTributarioRepository(remoteDataSource: EstadoTributarioRemoteDataSource(api: EstadoTributarioApi()))) {
        self.repository = repository
    }
    
    /// Ejecuta el caso de uso para obtener la información del estado tributario.
    ///
    /// - Parameter ruc: El ruc a consultar.
    /// - Returns: E modelo de información del estado tributario.
    func execute(ruc: String) async throws -> EstadoTributarioModel {
        return try await repository.obtenerEstadoTributario(ruc: ruc)
    }
    
}
