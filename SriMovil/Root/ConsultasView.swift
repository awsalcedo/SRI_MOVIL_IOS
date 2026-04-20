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
    @State private var showLogin = false
    
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
            .background(AppColors.background)
            .navigationTitle("Servicios")
            .navigationBarTitleDisplayMode(.large)
            .searchable(
                text: $viewModel.textoBuscar,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Buscar servicio"
            )
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showLogin = true
                    } label: {
                        Label("Ingresar", systemImage: "person.crop.circle")
                    }
                    
                    Button {
                        showConfiguracion = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .sheet(isPresented: $showConfiguracion) {
                ConfiguracionView()
            }
            .sheet(isPresented: $showLogin) {
                LoginView()
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
            LazyVStack(alignment: .leading, spacing: AppSpacing.xLarge) {
                BannerHeroView()
                    .padding(.top, 8)
                
                if !viewModel.serviciosDestacados.isEmpty {
                    SectionBlock(title: "Consultas frecuentes") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.serviciosDestacados) { servicio in
                                    NavigationLink {
                                        ServicioDestinationBuilder.build(for: servicio.destino)
                                    } label: {
                                        ServicioDestacadoCard(servicio: servicio)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, AppSpacing.large)
                        }
                    }
                }
                
                ForEach(viewModel.categoriasVisibles) { categoria in
                    let items = viewModel.servicios(for: categoria)
                    
                    SectionBlock(title: categoria.titulo) {
                        VStack(spacing: 12) {
                            ForEach(items) { servicio in
                                NavigationLink {
                                    ServicioDestinationBuilder.build(for: servicio.destino)
                                } label: {
                                    ServicioRowCard(servicio: servicio)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, AppSpacing.large)
                    }
                }
                
                if viewModel.serviciosFiltrados.isEmpty {
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
            .tint(AppColors.primary)
        }
    }
}

#Preview {
    ConsultasView()
}
