//
//  ServiciosConsulta.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import Foundation

final class ServiciosConsultaInteractor: ServiciosConsultaInteractorProtocol {
    
    func obtenerServicios() async throws -> [Servicio] {
        ServiciosMockData.items
    }
}
