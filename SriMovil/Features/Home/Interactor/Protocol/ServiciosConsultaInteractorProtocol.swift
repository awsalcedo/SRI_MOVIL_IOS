//
//  ServiciosConsultaProtocol.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import Foundation

protocol ServiciosConsultaInteractorProtocol: Sendable {
    func obtenerServicios() async throws -> [Servicio]
}
