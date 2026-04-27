//
//  ConsultasView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI
import Observation

struct ConsultasView: View {
    
    // MARK: - Propiedades
    
    @State private var viewModel = ServiciosConsultaViewModel()
    @State private var showConfiguracion = false
    @State private var showAccountLogin = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    loadingView
                    
                case .success:
                    contentView
                    
                case .failure(let message, _):
                    errorView(message: message)
                }
            }
            .background(SRIColors.background)
            .navigationTitle("Servicios")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 8) {
                        /*Button {
                         showLogin = true
                         } label: {
                         Image(systemName: "person.crop.circle")
                         }*/
                        
                        Button {
                            showConfiguracion = true
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    }
                    .padding(8)
                }
            }
            .sheet(isPresented: $showConfiguracion) {
                ConfiguracionView()
            }
            .sheet(
                isPresented: Binding(
                    get: { viewModel.showLogin },
                    set: { newValue in
                        if !newValue {
                            viewModel.dismissLogin()
                        }
                    }
                )
            ) {
                LoginView { model in
                    viewModel.didLoginSuccessfully(model)
                }
            }
            .navigationDestination(
                isPresented: Binding(
                    get: { viewModel.showComprobantesElectronicos },
                    set: { viewModel.showComprobantesElectronicos = $0 }
                )
            ) {
                ComprobantesElectronicosView(
                    razonSocial: viewModel.razonSocialAutenticada,
                    onOpenAccount: {
                        showAccountLogin = true
                    }
                )
            }
            .fullScreenCover(isPresented: $showAccountLogin) {
                NavigationStack {
                    LoginView(
                        onLoginSuccess: { _ in
                            showAccountLogin = false
                        },
                        onSessionEnded: {
                            viewModel.showComprobantesElectronicos = false
                            showAccountLogin = false
                        },
                        onSwitchUser: {
                            viewModel.showComprobantesElectronicos = false
                        },
                        onCancelAfterSwitchUser: {
                            showAccountLogin = false
                        }
                    )
                    .navigationTitle("Cuenta")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .task {
                if case .idle = viewModel.state {
                    await viewModel.cargarServicios()
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .controlSize(.large)
            
            Text("Cargando servicios...")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var contentView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: SRISpacing.xxLarge) {
                BannerHeroView()
                    .padding(.top, 8)
                    .padding(.horizontal, SRISpacing.large)
                
                if !viewModel.serviciosExternosFiltrados.isEmpty {
                    SectionBlock(title: "Servicios en línea") {
                        ServiciosExternosGroupedList(servicios: viewModel.serviciosExternosFiltrados)
                            .padding(.horizontal, SRISpacing.large)
                    }
                }
                
                if !viewModel.serviciosDestacados.isEmpty {
                    SectionBlock(title: "Consultas frecuentes") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.serviciosDestacados) { servicio in
                                    servicioDestacadoDestination(for: servicio)
                                }
                            }
                            .padding(.horizontal, SRISpacing.large)
                        }
                    }
                }
                
                if !viewModel.serviciosPrincipales.isEmpty {
                    SectionBlock(title: "Consultas disponibles") {
                        VStack(spacing: 10) {
                            ForEach(viewModel.serviciosPrincipales) { servicio in
                                servicioRowDestination(for: servicio)
                            }
                            
                            if viewModel.hasMoreServiciosNativos {
                                NavigationLink {
                                    ServiciosDisponiblesView(
                                        categorias: viewModel.categoriasVisibles,
                                        serviciosProvider: { categoria in
                                            viewModel.servicios(for: categoria)
                                        },
                                        rowBuilder: { servicio in
                                            AnyView(servicioRowDestination(for: servicio))
                                        }
                                    )
                                } label: {
                                    VerMasServiciosRow()
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                
                if !viewModel.hasServiciosFiltrados {
                    ContentUnavailableView(
                        "No se encontraron servicios",
                        systemImage: "magnifyingglass",
                        description: Text("Prueba con otro término de búsqueda.")
                    )
                    .padding(.top, 24)
                }
            }
            .padding(.bottom, 24)
        }
        .scrollIndicators(.hidden)
    }
    
    // MARK: - Navigation Builders
    
    @ViewBuilder
    private func servicioRowDestination(for servicio: Servicio) -> some View {
        if viewModel.requiresLogin(servicio) {
            Button {
                viewModel.didSelectServicio(servicio)
            } label: {
                ServicioRowCard(servicio: servicio)
            }
            .buttonStyle(.plain)
        } else {
            NavigationLink {
                ServicioDestinationBuilder.build(for: servicio.destino)
            } label: {
                ServicioRowCard(servicio: servicio)
            }
            .buttonStyle(.plain)
        }
    }
    
    @ViewBuilder
    private func servicioDestacadoDestination(for servicio: Servicio) -> some View {
        if viewModel.requiresLogin(servicio) {
            Button {
                viewModel.didSelectServicio(servicio)
            } label: {
                ServicioDestacadoCard(servicio: servicio)
            }
            .buttonStyle(.plain)
        } else {
            NavigationLink {
                ServicioDestinationBuilder.build(for: servicio.destino)
            } label: {
                ServicioDestacadoCard(servicio: servicio)
            }
            .buttonStyle(.plain)
        }
    }
    
    // MARK: - Helpers
    
    private func errorView(message: String) -> some View {
        ContentUnavailableView {
            Label("No se pudieron cargar los servicios", systemImage: "wifi.exclamationmark")
        } description: {
            Text(message)
        } actions: {
            Button("Reintentar") {
                Task {
                    await viewModel.reintentarCarga()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(SRIColors.primary)
        }
    }
}

#Preview {
    ConsultasView()
}
