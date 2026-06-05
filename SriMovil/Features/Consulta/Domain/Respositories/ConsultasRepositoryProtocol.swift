//
//  ConsultasRepositoryProtocol.swift
//  SriMovil
//
//  Created by usradmin on 4/6/26.
//

import Foundation

protocol ConsultasRepositoryProtocol: Sendable {
    func getConsultas() throws -> [ConsultaItemModel]
}
