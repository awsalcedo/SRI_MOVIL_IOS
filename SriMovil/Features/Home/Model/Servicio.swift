//
//  Servicio.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import Foundation

struct Servicio: Identifiable, Codable, Hashable {
    let id: UUID
    let nombreServicio: String
    let imagenServicio: String?
    let categoria: CategoriaServicio
    let destino: ServicioDestino
    let esDestacado: Bool
    
    init(
        id: UUID = UUID(),
        nombreServicio: String,
        imagenServicio: String?,
        categoria: CategoriaServicio,
        destino: ServicioDestino,
        esDestacado: Bool = false
    ) {
        self.id = id
        self.nombreServicio = nombreServicio
        self.imagenServicio = imagenServicio
        self.categoria = categoria
        self.destino = destino
        self.esDestacado = esDestacado
    }
}
