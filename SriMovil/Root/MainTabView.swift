//
//  MainTabView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ConsultasView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ComprobantesView()
                .tabItem {
                    Label("Login", systemImage: "person.fill")
                }
            
            NoticiasView()
                .tabItem {
                    Label("Noticias", systemImage: "newspaper")
                }
        }
        .accentColor(.blue)
    }
}

#Preview {
    MainTabView()
}
