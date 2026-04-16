//
//  EstadoTributarioInteractorProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 25/3/26.
//

import Foundation

protocol EstadoTributarioInteractorProtocol: Sendable {
    func obtenerEstadoTributario(ruc: String) async throws -> EstadoTributarioModel
}
