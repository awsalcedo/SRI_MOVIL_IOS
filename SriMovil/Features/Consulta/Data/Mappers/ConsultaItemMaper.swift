//
//  ConsultaItemMaper.swift
//  SriMovil
//
//  Created by usradmin on 4/6/26.
//

import Foundation

/// Convierte objetos de transferencia de datos de consultas
/// en modelos de dominio utilizados por la aplicación.
///
/// `ConsultaItemMapper` encapsula la transformación entre
/// `ConsultaItemDTO` y `ConsultaItemModel`,
/// evitando que las capas superiores dependan de detalles
/// de implementación del origen de datos.
///
/// Este tipo no mantiene estado interno.
/// Todas sus funciones son puras y deterministas.
struct ConsultaItemMaper {
    
    /// Convierte un DTO de consulta en un modelo de dominio.
    ///
    /// - Parameter dto: DTO obtenido desde el origen local.
    /// - Returns: Modelo de dominio listo para ser utilizado
    ///   por los casos de uso y la capa de presentación.
    static func toDomain(_ dto: ConsultaItemDto) -> ConsultaItemModel {
        ConsultaItemModel(
            id: dto.id,
            title: dto.title,
            icon: dto.icon,
            type: ConsultaType(rawValue: dto.type) ?? .unknown,
            isCentered: dto.isCentered ?? false)
    }
    
    /// Convierte una colección de DTOs de consultas en modelos de dominio.
    ///
    /// - Parameter dtos: Colección de DTOs obtenida desde el origen local.
    /// - Returns: Colección de modelos de dominio lista para ser consumida
    ///   por la capa de dominio o presentación.
    static func toDomain(_ dtos: [ConsultaItemDto]) -> [ConsultaItemModel] {
        dtos.map { toDomain($0) }
    }
}
