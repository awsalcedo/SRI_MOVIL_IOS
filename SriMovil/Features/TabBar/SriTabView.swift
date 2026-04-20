//
//  SriTabView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct SriTabView: View {
    
    enum Tabss: CaseIterable, Hashable {
        case consultas
        case noticias
        case agencias
        case perfil
        
        var title: String {
            switch self {
            case .consultas: return "Consultas"
            case .noticias: return "Noticias"
            case .agencias: return "Agencias"
            case .perfil: return "Perfil"
            }
        }
        
        var icon: String {
            switch self {
            case .consultas: return "house"
            case .noticias: return "newspaper"
            case .agencias: return "building.2"
            case .perfil: return "person"
            }
        }
        
        var selectedIcon: String {
            switch self {
            case .consultas: return "house.fill"
            case .noticias: return "newspaper.fill"
            case .agencias: return "building.2.fill"
            case .perfil: return "person.fill"
            }
        }
    }
    
    @State private var selectedTab: Tabss = .consultas
    @Namespace private var tabAnimation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            currentScreen
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(edges: .bottom)
            
            FloatingSriBottomBar(
                selectedTab: $selectedTab,
                namespace: tabAnimation,
                onSearchTapped: {
                    print("Buscar")
                }
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 6)
        }
        .toolbar(.hidden, for: .tabBar)
        .background(Color.clear)
    }
    
    @ViewBuilder
    private var currentScreen: some View {
        switch selectedTab {
        case .consultas:
            ConsultasView()
        case .noticias:
            NoticiasView()
        case .agencias:
            AgenciasView()
        case .perfil:
            LoginContainerView()
        }
    }
}

private struct FloatingSriBottomBar: View {
    
    @Binding var selectedTab: SriTabView.Tabss
    let namespace: Namespace.ID
    let onSearchTapped: () -> Void
    
    private let barHeight: CGFloat = 68
    private let searchSize: CGFloat = 68
    
    var body: some View {
        HStack(spacing: 12) {
            tabsContainer
                .frame(maxWidth: .infinity)
            
            searchButton
                .frame(width: searchSize, height: searchSize)
        }
    }
    
    private var tabsContainer: some View {
        HStack(spacing: 6) {
            ForEach(SriTabView.Tabss.allCases, id: \.self) { tab in
                tabButton(for: tab)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .frame(height: barHeight)
        .background {
            Capsule()
                .fill(.ultraThinMaterial)
                .overlay {
                    Capsule()
                        .fill(SriTabBarPalette.glassTint)
                }
        }
        .overlay {
            Capsule()
                .strokeBorder(.white.opacity(0.22), lineWidth: 0.8)
        }
        .overlay(alignment: .top) {
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.22),
                            .white.opacity(0.08),
                            .clear
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .padding(1)
        }
        .shadow(color: SriTabBarPalette.primary.opacity(0.10), radius: 14, x: 0, y: 4)
    }
    
    private var searchButton: some View {
        Button(action: onSearchTapped) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(SriTabBarPalette.primary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .overlay {
                            Circle()
                                .fill(SriTabBarPalette.glassTint)
                        }
                }
                .overlay {
                    Circle()
                        .strokeBorder(.white.opacity(0.22), lineWidth: 0.8)
                }
                .overlay(alignment: .top) {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0.22),
                                    .white.opacity(0.08),
                                    .clear
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .padding(1)
                }
        }
        .buttonStyle(.plain)
        .shadow(color: SriTabBarPalette.primary.opacity(0.10), radius: 14, x: 0, y: 4)
        .accessibilityLabel("Buscar")
    }
    
    private func tabButton(for tab: SriTabView.Tabss) -> some View {
        let isSelected = selectedTab == tab
        
        return Button {
            withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) {
                selectedTab = tab
            }
        } label: {
            Image(systemName: isSelected ? tab.selectedIcon : tab.icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(
                    isSelected
                    ? SriTabBarPalette.primary
                    : SriTabBarPalette.primary.opacity(0.62)
                )
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background {
                    if isSelected {
                        Capsule()
                            .fill(SriTabBarPalette.selectedTint)
                            .overlay {
                                Capsule()
                                    .strokeBorder(.white.opacity(0.26), lineWidth: 0.7)
                            }
                            .overlay(alignment: .top) {
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                .white.opacity(0.22),
                                                .clear
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .padding(1)
                            }
                            .matchedGeometryEffect(id: "selected-tab", in: namespace)
                    }
                }
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(tab.title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

private enum SriTabBarPalette {
    // Ajusta estos valores a tus colores institucionales reales
    static let primary = Color(red: 0.00, green: 0.36, blue: 0.72)
    
    // Tinte general del vidrio
    static let glassTint = LinearGradient(
        colors: [
            Color.white.opacity(0.18),
            Color(red: 0.00, green: 0.36, blue: 0.72).opacity(0.08)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Tinte del tab seleccionado
    static let selectedTint = LinearGradient(
        colors: [
            Color(red: 0.00, green: 0.36, blue: 0.72).opacity(0.18),
            Color.white.opacity(0.16)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

#Preview("Only Bottom Bar") {
    ZStack {
        LinearGradient(
            colors: [
                Color.white,
                Color(red: 0.94, green: 0.97, blue: 1.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        FloatingSriBottomBar(
            selectedTab: .constant(.consultas),
            namespace: Namespace().wrappedValue,
            onSearchTapped: {}
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 6)
    }
}

#Preview("SriTabView") {
    SriTabView()
}
