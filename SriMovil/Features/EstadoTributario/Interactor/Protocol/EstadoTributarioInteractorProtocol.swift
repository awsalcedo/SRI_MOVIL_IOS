//
//  EstadoTributarioInteractorProtocol.swift
//  SriMovil
//
//  Created by usradmin on 25/3/26.
//

import Foundation

protocol EstadoTributarioInteractorProtocol: Sendable {
    func obtenerEstadoTributario(ruc: String) async throws -> EstadoTributarioModel
}
