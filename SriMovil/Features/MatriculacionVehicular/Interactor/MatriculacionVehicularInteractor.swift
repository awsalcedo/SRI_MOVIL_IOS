//
//  MatriculacionVehicularInteractor.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 16/4/26.
//

import Foundation

final class MatriculacionVehicularInteractor: MatriculacionVehicularInteractorProtocol {
    
    // MARK: - Propiedades Privadas
    
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Inicializadores
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Funciones
    
    func obtenerInfoVehiculo(idVehiculo: String) async throws -> InfoVehiculoModel {
        let dto: InfoVehiculoDto = try await networkService.get(url: .matriculacionVehicular(idVehiculo: idVehiculo))
        return dto.toDomain()
    }
}
