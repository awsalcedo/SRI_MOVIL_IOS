//
//  EstadoRemoteDataSourceType.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation

protocol EstadoRemoteDataSourceType {
    /// Obtiene el estado desde un origen remoto.
    /// - Returns: Un `Result` que contiene `EstadoDto` en caso de éxito, o un `HttpClientError` en caso de error.
    func obtenerEstado() async -> Result<EstadoDto, HttpClientError>
}
