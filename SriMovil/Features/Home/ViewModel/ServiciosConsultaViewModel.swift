//
//  ServiciosConsultaViewModel.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class ServiciosConsultaViewModel: ServiciosConsultaViewModelProtocol {
    
    // MARK: - Propiedades públicas
    
    var state: ViewState<[Servicio]> = .idle
    var textoBuscar: String = ""
    
    var showLogin = false
    var showComprobantesElectronicos = false
    var razonSocialAutenticada = ""
    
    // MARK: - Propiedades Privadas
    
    @ObservationIgnored
    private let interactor: ServiciosConsultaInteractorProtocol
    
    @ObservationIgnored
    private let loadStoredSessionInteractor: LoadStoredSessionInteractorProtocol
    
    // MARK: - Inicializadores
    
    init(
        interactor: ServiciosConsultaInteractorProtocol = ServiciosConsultaInteractor(),
        loadStoredSessionInteractor: LoadStoredSessionInteractorProtocol = LoadStoredSessionInteractor()
    ) {
        self.interactor = interactor
        self.loadStoredSessionInteractor = loadStoredSessionInteractor
    }
    
    // MARK: - Propiedades Computadas
    
    var serviciosFiltrados: [Servicio] {
        guard case let  .success(servicios) = state else {
            return []
        }
        
        let query = textoBuscar.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !query.isEmpty else {
            return servicios
        }
        
        return servicios.filter { servicio in
            servicio.nombreServicio.localizedCaseInsensitiveContains(query) || servicio.categoria.titulo.localizedCaseInsensitiveContains(query)
        }
    }
    
    var serviciosDestacados: [Servicio] {
        serviciosFiltrados.filter(\.esDestacado)
    }
    
    var categoriasVisibles: [CategoriaServicio] {
        CategoriaServicio.allCases.filter { categoria in
            serviciosFiltrados.contains(where: {$0.categoria == categoria})
        }
    }
    
    // MARK: - Funciones
    
    func cargarServicios() async {
        state = .loading
        
        do {
            let servicios = try await interactor.obtenerServicios()
            state = .success(servicios)
        } catch {
            state = .failure(
                message: error.localizedDescription.isEmpty
                ? "No fue posible cargar los servicios."
                : error.localizedDescription,
                isInlineFieldError: false
            )
        }
    }
    
    func servicios(for categoria: CategoriaServicio) -> [Servicio] {
        serviciosFiltrados.filter { $0.categoria == categoria }
    }
    
    func reintentarCarga() async {
        await cargarServicios()
    }
    
    func didSelectServicio(_ servicio: Servicio) {
        guard requiresLogin(servicio) else {
            return
        }
        
        do {
            let snapshot = try loadStoredSessionInteractor.loadStoredSession()
            
            if snapshot.autenticado {
                razonSocialAutenticada = snapshot.razonSocial ?? ""
                showComprobantesElectronicos = true
            } else {
                showLogin = true
            }
        } catch {
            showLogin = true
        }
    }
    
    func didLoginSuccessfully(_ model: LoginScreenModel) {
        razonSocialAutenticada = model.razonSocialContribuyente ?? ""
        showLogin = false
        showComprobantesElectronicos = true
    }
    
    func dismissLogin() {
        showLogin = false
    }
    
    func requiresLogin(_ servicio: Servicio) -> Bool {
        servicio.nombreServicio.localizedCaseInsensitiveContains("Comprobantes")
    }
}
