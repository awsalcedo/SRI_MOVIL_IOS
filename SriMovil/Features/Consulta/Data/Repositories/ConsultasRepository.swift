//
//  ConsultasRepository.swift
//  SriMovil
//
//  Created by usradmin on 4/6/26.
//

import Foundation

final class ConsultasRepository: ConsultasRepositoryProtocol {
    private let localDataSource: ConsultasLocalDataSourceProtocol
    
    init(localDataSource: ConsultasLocalDataSourceProtocol = ConsultasLocalDataSource()) {
        self.localDataSource = localDataSource
    }
    
    func getConsultas() throws -> [ConsultaItemModel] {
        let dtos = try localDataSource.getConsultas()
        return ConsultaItemMaper.toDomain(dtos)
    }
}
