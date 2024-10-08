//
//  EstadoTributarioRepository.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

struct EstadoTributarioRepository: EstadoTributarioRepositoryProtocol {
    
    private let remoteDataSource: EstadoTributarioRemoteDataSourceProtocol
    
    init(remoteDataSource: EstadoTributarioRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func obtenerEstadoTributario(ruc: String) async throws -> EstadoTributarioModel {
        return try await remoteDataSource.obtenerEstadoTributarioRemote(ruc: ruc)
    }
    
}
