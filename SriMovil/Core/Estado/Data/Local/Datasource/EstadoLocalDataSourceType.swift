//
//  EstadoLocalDataSourceType.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation

protocol EstadoLocalDataSourceType {
    func guardarEstado(_ estado: EstadoDto) throws
    func obtenerEstado() throws -> EstadoDto?
}
