//
//  SriTabView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct SriTabView: View {
    
    enum Tab: Int {
        case consultas = 0
        case noticias
        case agencias
        case login
    }
    
    @State private var selectedTab: Tab = .consultas
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            ConsultasView()
                .tabItem {
                    Image(systemName: selectedTab == .consultas ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == .consultas ? .fill : .none)
                }
                //.onAppear { selectedTab = 0 }
                .tag(Tab.consultas)
            
            NoticiasView()
                .tabItem {
                    Image(systemName: selectedTab == .noticias ? "newspaper.fill" : "newspaper")
                        .environment(\.symbolVariants, selectedTab == .noticias ? .fill : .none)
                }
                //.onAppear { selectedTab = 1 }
                .tag(Tab.noticias)
            
            AgenciasView()
                .tabItem {
                    Image(systemName: selectedTab == .agencias ? "building.2.fill" : "building.2")
                        .environment(\.symbolVariants, selectedTab == .agencias ? .fill : .none)
                }
                //.onAppear { selectedTab = 2}
                .tag(Tab.agencias)
            
            LoginContainerView()
                .tabItem {
                    Image(systemName: selectedTab == .login ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == .login ? .fill : .none)
                }
                //.onAppear { selectedTab = 3 }
                .tag(Tab.login)
            
        }
    }
}

#Preview {
    SriTabView()
}
