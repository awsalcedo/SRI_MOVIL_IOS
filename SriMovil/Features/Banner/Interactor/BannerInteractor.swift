//
//  BannerInteractor.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 21/4/26.
//

import Foundation

/// Interactor encargado de resolver el caso de uso de obtención del banner.
///
/// Su responsabilidad es:
/// - invocar el servicio de red;
/// - decodificar la respuesta remota;
/// - mapear el DTO a `BannerModel`.
///
/// No maneja estado de UI ni lógica de presentación.
final class BannerInteractor: BannerInteractorProtocol {
    
    // MARK: - Propiedades Privadas
    
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Inicializadores
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Funciones
    
    func obtenerBanner() async throws -> BannerModel {
        let dto: BannerDto = try await networkService.get(url: .banner)
        return dto.toDomain()
    }
}
