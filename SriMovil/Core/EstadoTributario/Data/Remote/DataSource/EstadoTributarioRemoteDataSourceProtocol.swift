//
//  EstadoTributarioRemoteDataSourceProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

protocol EstadoTributarioRemoteDataSourceProtocol {
    func obtenerEstadoTributarioRemote(ruc: String) async throws -> EstadoTributarioModel
}
