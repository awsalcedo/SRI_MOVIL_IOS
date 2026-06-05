//
//  ConsultasLocalDataSourceProtocol.swift
//  SriMovil
//
//  Created by usradmin on 4/6/26.
//

import Foundation

protocol ConsultasLocalDataSourceProtocol: Sendable {
    func getConsultas() throws -> [ConsultaItemDto]
}
