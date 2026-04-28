//
//  BannerMapper.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 28/4/26.
//

import Foundation

/// Convierte objetos de transferencia de datos del banner en modelos de dominio.
///
/// `BannerMapper` centraliza la transformación entre la respuesta remota
/// representada por `BannerDto` y el modelo utilizado por las capas de dominio
/// y presentación, `BannerModel`.
///
/// Este tipo no mantiene estado interno. Sus funciones son puras y deterministas:
/// para una misma entrada siempre producen la misma salida.
///
/// Mantener esta conversión en `Data/Mappers` evita que el DTO conozca
/// directamente cómo se construyen los modelos de dominio.
struct BannerMapper {
    
    /// Convierte un DTO de banner en un modelo de dominio.
    ///
    /// Este método copia únicamente los valores necesarios desde `BannerDto`
    /// hacia `BannerModel`, manteniendo aislado el contrato remoto de la API
    /// respecto al modelo usado por la aplicación.
    ///
    /// - Parameter dto: Objeto de transferencia de datos recibido desde el servicio remoto.
    /// - Returns: Una instancia de `BannerModel` lista para ser utilizada por el dominio o la UI.
    static func toDomain(_ dto: BannerDto) -> BannerModel {
        BannerModel(
            imagen64: dto.imagen64,
            url: dto.url,
            predeterminado: dto.predeterminado
        )
    }
}
