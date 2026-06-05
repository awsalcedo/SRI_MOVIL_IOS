//
//  ConsultasView.swift
//  SriMovil
//
//  Created by usradmin on 5/6/26.
//

import SwiftUI
import Observation

/// Pantalla principal de consultas de SRIMOVIL.
///
/// Replica la estructura visual de la pantalla legacy:
/// encabezado superior, menú de acceso rápido, listado de servicios,
/// banner informativo y pie de página.
///
/// La vista consume el estado publicado por `ConsultasViewModel` y no obtiene
/// datos directamente desde la capa Data.
struct ConsultasLegadaView: View {
    
    // MARK: - Constantes
        
    private enum Layout {
            static let headerHeight: CGFloat = 44
            static let logoWidth: CGFloat = 115
            static let logoHeight: CGFloat = 36
            static let horizontalPadding: CGFloat = 14
            static let menuWidth: CGFloat = 180
            static let menuTopPadding: CGFloat = 44
        }
        
    // MARK: - Propiedades
        
    @State private var viewModel = ConsultasViewModel()
    @State private var isMenuVisible = false
    
    // MARK: - Body
    
    var body: some View {

        NavigationStack {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 0) {
                    headerView
                    content
                }
                
                if isMenuVisible {
                    menuView
                        .zIndex(2)
                }
            }
            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
            .toolbar(.hidden, for: .navigationBar)
            .task {
                if case .idle = viewModel.state {
                    await viewModel.obtenerConsultas()
                }
            }
        }
        
        }
    
    // MARK: - Content
        
    @ViewBuilder
        private var content: some View {
            switch viewModel.state {
            case .idle, .loading:
                loadingView
                
            case .success(let consultas):
                consultasContentView(consultas)
                
            case .failure(let message, _):
                errorView(message: message)
            }
        }
        
        // MARK: - Subviews
        
    private var headerView: some View {
            HStack {
                Image("sri_32")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Layout.logoWidth, height: Layout.logoHeight)
                
                Spacer()
                
                Button {
                    isMenuVisible.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 24, weight: .bold))
                        .rotationEffect(.degrees(90))
                        .foregroundStyle(.white)
                        .frame(width: 32, height: Layout.headerHeight)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Menú")
            }
            .padding(.leading, Layout.horizontalPadding)
            .padding(.trailing, 6)
            .frame(height: Layout.headerHeight)
            .background(Color(red: 0.02, green: 0.00, blue: 0.65))
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(Color.gray.opacity(0.45))
                    .frame(height: 1)
            }
        }
        
        private var loadingView: some View {
            ProgressView(AppStrings.Common.loading)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
    private func consultasContentView(_ consultas: [ConsultaItemModel]) -> some View {
        ScrollView(showsIndicators: true) {
            LazyVStack(spacing: 0) {
                ForEach(consultas) { item in
                    if let route = route(for: item.type) {
                        NavigationLink {
                            ConsultaDestinationBuilder.build(for: route)
                        } label: {
                            ConsultaRowView(item: item)
                        }
                        .buttonStyle(.plain)
                    } else {
                        ConsultaRowView(item: item)
                    }
                }
                
                BannerHeroView()
                    .padding(.top, 10)
                    .padding(.horizontal, 16)
                
                footerView
                    .padding(.top, 4)
                    .padding(.bottom, 18)
            }
        }
    }
        
    private var menuView: some View {
            VStack(alignment: .leading, spacing: 0) {
                menuButton("Noticias") { }
                menuButton("Agencias") { }
                menuButton("Iniciar Sesión") { }
            }
            .frame(width: Layout.menuWidth)
            .background(Color.white)
            .overlay {
                Rectangle()
                    .stroke(Color.gray.opacity(0.35), lineWidth: 1)
            }
            .shadow(radius: 4)
            .padding(.top, Layout.menuTopPadding)
            .padding(.trailing, 6)
        }
        
    private func menuButton(
            _ title: String,
            action: @escaping () -> Void
        ) -> some View {
            Button {
                isMenuVisible = false
                action()
            } label: {
                Text(title)
                    .font(.system(size: 16))
                    .foregroundStyle(Color(red: 0.25, green: 0.28, blue: 0.32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 44)
                    .padding(.horizontal, 14)
            }
            .buttonStyle(.plain)
        }
        
    private var footerView: some View {
            Text("Copyright (c) 2014 Servicio de Rentas Internas.\nTodos los derechos reservados.")
                .font(.system(size: 13))
                .italic()
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
        }
        
        private func errorView(message: String) -> some View {
            VStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 32))
                    .foregroundStyle(.orange)
                
                Text(message)
                    .font(.system(size: 16))
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                
                Button(AppStrings.Common.retry) {
                    Task {
                        await viewModel.obtenerConsultas()
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        // MARK: - Acciones
    
    private func route(for type: ConsultaType) -> ConsultaRoute? {
        switch type {
        case .comprobantesElectronicos:
            return .comprobantesElectronicos
        case .estadoTributario:
            return .estadoTributario
        case .valoresPagar:
            return .valoresPagar
        case .deudas:
            return .deudas
        case .validezComprobantes:
            return .validezComprobantes
        case .impuestoRenta:
            return .impuestoRenta
        case .certificados:
            return .certificados
        case .seguimientoTramites:
            return .seguimientoTramites
        case .validacionQR:
            return .validacionQR
        case .citaPrevia:
            return .citaPrevia
        case .calculadoras:
            return .calculadoras
        case .denuncias:
            return .denuncias
        case .contactenos:
            return .contactenos
        case .simar:
            return .simar
        case .facturadorSRI:
            return .facturadorSRI
        case .configuracion:
            return .configuracion
        case .politicaDatos:
            return .politicaDatos
        case .unknown:
            return nil
        }
    }
}

#Preview("ConsultasLegadaView") {
    ConsultasLegadaView()
}
