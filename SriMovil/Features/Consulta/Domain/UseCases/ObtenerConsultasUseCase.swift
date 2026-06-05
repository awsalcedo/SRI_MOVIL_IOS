//
//  ObtenerConsultasUseCase.swift
//  SriMovil
//
//  Created by usradmin on 5/6/26.
//

import Foundation

final class ObtenerConsultasUseCase: ObtenerConsultasUseCaseProtocol {
    
    // MARK: - Propiedades Privadas
    private let repository: ConsultasRepositoryProtocol
    
    // MARK: - Inicializadores
    init(repository: ConsultasRepositoryProtocol = ConsultasRepository()) {
        self.repository = repository
    }
    
    // MARK: - Funciones
    func execute() async throws -> [ConsultaItemModel] {
        try repository.getConsultas()
    }
}
