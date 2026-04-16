//
//  DeudasProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 30/3/26.
//

import Foundation

protocol DeudasInteractoProtocol: Sendable {
    func consultarPorNombre(nombre: String, tipoPersona: String, resultados: Int) async throws -> DeudasModel
    func consultarPorIdentificacion(identificacion: String, tipoPersona: String) async throws -> DeudasModel
}
