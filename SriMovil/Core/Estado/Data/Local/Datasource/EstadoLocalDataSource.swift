//
//  EstadoLocalDataSource.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation
import CoreData
import Factory
/*
 UserDefaults: Cuando solo necesitas almacenar configuraciones simples o datos pequeños que no requieren estructuras complejas.
 
 CoreData: Cuando estás manejando datos más complejos o volúmenes más grandes de información, especialmente si necesitas realizar consultas avanzadas o manejar relaciones entre datos. También es la opción preferida si planeas escalar la aplicación o si los datos que estás almacenando son esenciales para la funcionalidad principal de la aplicación.
 */

class EstadoLocalDataSource: EstadoLocalDataSourceType {
    
    @Injected(\.managedObjectContext) private var context
    
    func guardarEstado(_ estado: EstadoDto) throws {
        let estadoEntity = EstadoEntity(context: context)
        estadoEntity.mensajeGeneral = estado.mensajeGeneral
        estadoEntity.mensajeDestacado = estado.mensajeDestacado
        estadoEntity.fechaEstado = Int16(estado.fechaEstado)
        estadoEntity.fechaInfoAgencias = Int16(estado.fechaInfoAgencias)
        estadoEntity.fechaBanner = Int16(estado.fechaBanner)
        estadoEntity.habilitado = estado.habilitado
        
        // Mapea y guarda el array de estadoConsultas
        estadoEntity.estadoConsultas = NSSet(array: estado.estadoConsultas.map { estadoConsultaDto in
            let estadoConsultaEntity = EstadoConsultaEntity(context: context)
            estadoConsultaEntity.idConsulta = estadoConsultaDto.idConsulta
            estadoConsultaEntity.habilitada = estadoConsultaDto.habilitada
            estadoConsultaEntity.mensajeSecundario = estadoConsultaDto.mensajeSecundario
            return estadoConsultaEntity
        })
        
        // Mapea y guarda el array de estadoInterno
        estadoEntity.estado = NSSet(array: estado.estado.map { estadoInternoDto in
            let estadoInternoEntity = EstadoInternoEntity(context: context)
            estadoInternoEntity.idConsulta = estadoInternoDto.idConsulta
            estadoInternoEntity.habilitada = estadoInternoDto.habilitada
            estadoInternoEntity.mensajeSecundario = estadoInternoDto.mensajeSecundario
            return estadoInternoEntity
        })
        
        do {
            try context.save()
        } catch {
            throw CoreDataError.saveError(error)
        }
    }
    
    func obtenerEstado() throws -> EstadoDto? {
        let fetchRequest: NSFetchRequest<EstadoEntity> = EstadoEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        do {
            if let estadoEntity = try context.fetch(fetchRequest).first {
                let estadoConsultas = estadoEntity.estadoConsultas?.compactMap { $0 as? EstadoConsultaEntity }.map { consultaEntity in
                    EstadoConsultaDto(idConsulta: consultaEntity.idConsulta ?? "",
                                      habilitada: consultaEntity.habilitada,
                                      mensajeSecundario: consultaEntity.mensajeSecundario)
                } ?? []
                
                let estadoInterno = estadoEntity.estado?.compactMap { $0 as? EstadoInternoEntity }.map { estadoInternoEntity in
                    EstadoInternoDto(idConsulta: estadoInternoEntity.idConsulta ?? "",
                                     habilitada: estadoInternoEntity.habilitada,
                                     mensajeSecundario: estadoInternoEntity.mensajeSecundario)
                } ?? []
                
                return EstadoDto(
                    mensajeGeneral: estadoEntity.mensajeGeneral,
                    mensajeDestacado: estadoEntity.mensajeDestacado,
                    fechaEstado: Int(estadoEntity.fechaEstado),
                    fechaInfoAgencias: Int(estadoEntity.fechaInfoAgencias),
                    fechaBanner: Int(estadoEntity.fechaBanner),
                    habilitado: estadoEntity.habilitado,
                    estadoConsultas: estadoConsultas,
                    estado: estadoInterno
                )
            } else {
                throw CoreDataError.entityNotFound
            }
        } catch {
            throw CoreDataError.fetchError(error)
        }
    }
}
