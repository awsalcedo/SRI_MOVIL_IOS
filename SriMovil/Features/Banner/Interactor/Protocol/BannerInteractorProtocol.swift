//
//  BannerInteractorProtocol.swift
//  SriMovil
//
//  Created by usradmin on 21/4/26.
//

import Foundation

/// Define el contrato del interactor encargado de obtener el banner.
///
/// Este protocolo permite desacoplar el ViewModel de la implementación concreta,
/// facilitando pruebas unitarias y sustitución por mocks o stubs.
protocol BannerInteractorProtocol: Sendable {
    
    /// Obtiene el banner disponible para la pantalla principal de Consultas.
    ///
    /// - Returns: Un `BannerModel` con la información del banner.
    /// - Throws: Un error de red, decodificación o infraestructura.
    func obtenerBanner() async throws -> BannerModel
}
