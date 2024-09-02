//
//  BannerLocalDataSource.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 14/8/24.
//

import Foundation
import CoreData
import Factory

class BannerLocalDataSource: BannerLocalDataSourceType {
    
    @Injected(\.managedObjectContext) private var context
    
    func guardarBanner(banner: BannerModel) throws {
        let bannerEntity = BannerEntity(context: context)
        bannerEntity.imagen64 = banner.imagen64
        bannerEntity.url = banner.url
        bannerEntity.predeterminado = banner.predeterminado
        
        do {
            try context.save()
        } catch {
            throw CoreDataError.saveError(error)
        }
    }
    
    func obtenerBanner() throws -> BannerModel? {
        let fetchRequest: NSFetchRequest<BannerEntity> = BannerEntity.fetchRequest()
        /*
         En CoreData se utiliza para limitar la cantidad de resultados que se obtienen de una consulta. Específicamente, establece que solo se debe recuperar un máximo de un objeto de la base de datos, incluso si hay más objetos que coincidan con los criterios de la consulta.
         Optimización del rendimiento: Si solo necesitas un objeto de la base de datos, establecer un límite evita la sobrecarga de recuperar y manejar múltiples objetos.
         Consulta eficiente: Limitar el número de resultados puede hacer que las consultas sean más rápidas, ya que CoreData puede detenerse después de encontrar el número especificado de resultados.
         Evitar errores: Si esperas que solo haya un resultado, establecer un límite puede ayudar a evitar errores en tu lógica que puedan surgir si se recuperan múltiples resultados.
         */
        fetchRequest.fetchLimit = 1
        
        do {
            if let bannerEntity = try context.fetch(fetchRequest).first {
                // Convertir el BannerEntity a BannerModel
                return BannerModel(toEntity: bannerEntity)
            } else {
                throw CoreDataError.entityNotFound
            }
        } catch {
            throw CoreDataError.fetchError(error)
        }
    }
}
