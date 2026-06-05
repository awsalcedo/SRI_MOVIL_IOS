//
//  ObtenerConsultasUseCaseProtocol.swift
//  SriMovil
//
//  Created by usradmin on 5/6/26.
//

import Foundation

/// Caso de uso responsable de obtener las opciones disponibles
/// para la pantalla principal de consultas.
///
/// `ObtenerConsultasUseCase` pertenece a la capa Domain y expone
/// una operación de negocio independiente del origen de datos.
///
/// La capa Presentation utiliza este caso de uso sin conocer si las consultas
/// provienen de un archivo local, una base de datos o un servicio remoto.
protocol ObtenerConsultasUseCaseProtocol: Sendable {
    
    /// Obtiene las opciones de consultas disponibles.
    ///
    /// - Returns: Colección de modelos de dominio que representan las opciones
    ///   visibles en la pantalla principal de consultas.
    /// - Throws: Error propagado desde el repositorio si no se puede obtener
    ///   la información requerida.
    func execute() async throws -> [ConsultaItemModel]
}
