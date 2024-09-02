//
//  MainTabView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct MainTabView: View {
    /*var body: some View {
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
    }*/
    
    @State private var tabSelected: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $tabSelected) {
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
            }
            VStack {
                Spacer()
                CustomTabBarView(selectedTab: $tabSelected)
            }
        }
    }
}

#Preview {
    MainTabView()
}
