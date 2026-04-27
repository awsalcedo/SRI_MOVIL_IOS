//
//  BusquedaServiciosView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 17/4/26.
//

import SwiftUI

struct BusquedaServiciosView: View {
    
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Buscar",
                systemImage: "magnifyingglass",
                description: Text("Aquí podrás centralizar una búsqueda avanzada de servicios.")
            )
            .navigationTitle("Buscar")
        }
    }
}

#Preview {
    BusquedaServiciosView()
}
