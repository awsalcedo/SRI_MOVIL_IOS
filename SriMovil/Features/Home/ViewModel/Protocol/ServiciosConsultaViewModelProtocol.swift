//
//  ServiciosConsultaViewModelProtocol.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import Foundation

@MainActor
protocol ServiciosConsultaViewModelProtocol: Observable {
    
    // MARK: - Propiedades
    
    var state: ViewState<[Servicio]> { get set }
    var textoBuscar: String { get set }
    var serviciosFiltrados: [Servicio] { get }
    var serviciosDestacados: [Servicio] { get }
    var categoriasVisibles: [CategoriaServicio] { get }
    
    // MARK: - Funciones
    
    func cargarServicios() async
    func servicios(for categoria: CategoriaServicio) -> [Servicio]
    func reintentarCarga() async
}
