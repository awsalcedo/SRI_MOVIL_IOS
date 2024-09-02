//
//  EstadoRepository.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation
import Factory

protocol EstadoRepositoryType {
    func obtenerEstado() async -> Result<EstadoDto, Error>
}

class EstadoRepository: EstadoRepositoryType {
    @Injected(\.estadoRemoteDataSource) private var remoteDataSource
    @Injected(\.estadoLocalDataSource) private var localDataSource
    
    func obtenerEstado() async -> Result<EstadoDto, Error> {
        // Intentar obtener el estado desde el datasource remoto
        let remoteResult = await remoteDataSource.obtenerEstado()
        
        switch remoteResult {
        case .success(let estadoDto):
            // Si se obtiene exitosamente, guardar en el datasource local
            do {
                try localDataSource.guardarEstado(estadoDto)
                return .success(estadoDto)
            } catch {
                // Si ocurre un error al guardar en el local, retornarlo
                return .failure(error)
            }
            
        case .failure(let error):
            // Si falla la obtención remota, intentar obtener desde el local
            do {
                if let localEstado = try localDataSource.obtenerEstado() {
                    return .success(localEstado)
                } else {
                    // Si no se encuentra en el local, retornar el error remoto
                    return .failure(error)
                }
            } catch {
                // Si hay un error al obtener el estado local, retornar ese error
                return .failure(error)
            }
        }
    }
}
