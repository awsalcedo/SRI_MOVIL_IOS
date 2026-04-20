import SwiftUI

enum Tabs: String, CaseIterable, Hashable {
    case consultas
    case noticias
    case agencias
    case buscar

    var title: String {
        switch self {
        case .consultas: return "Consultas"
        case .noticias: return "Noticias"
        case .agencias: return "Agencias"
        case .buscar: return "Buscar"
        }
    }

    var icon: String {
        switch self {
        case .consultas: return "house"
        case .noticias: return "newspaper"
        case .agencias: return "building.2"
        case .buscar: return "magnifyingglass"
        }
    }
}

struct SriTabView: View {

    @State private var selectedTab: Tabs = .consultas
    @State private var searchText = ""

    var body: some View {
        TabView(selection: $selectedTab) {

            Tab(
                Tabs.consultas.title,
                systemImage: Tabs.consultas.icon,
                value: Tabs.consultas
            ) {
                ConsultasView()
            }

            Tab(
                Tabs.noticias.title,
                systemImage: Tabs.noticias.icon,
                value: Tabs.noticias
            ) {
                NoticiasView()
            }

            Tab(
                Tabs.agencias.title,
                systemImage: Tabs.agencias.icon,
                value: Tabs.agencias
            ) {
                AgenciasView()
            }

            Tab(
                value: Tabs.buscar,
                role: .search
            ) {
                NavigationStack {
                    BusquedaServiciosView()
                        .navigationTitle("Buscar")
                }
                .searchable(text: $searchText, prompt: "Buscar servicio")
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    SriTabView()
}
