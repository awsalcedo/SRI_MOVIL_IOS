//
//  EstadoTributarioApiProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

protocol EstadoTributarioApiProtocol {
    func makeRequest(ruc: String) async throws -> EstadoTributarioDTO
}
