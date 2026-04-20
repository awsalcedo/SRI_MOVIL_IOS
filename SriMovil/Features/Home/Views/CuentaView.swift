//
//  CuentaView.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import SwiftUI

struct CuentaView: View {
    
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Cuenta",
                systemImage: "person.crop.circle",
                description: Text("Aquí podrás centralizar el acceso del usuario y opciones relacionadas.")
            )
            .navigationTitle("Cuenta")
        }
    }
}

#Preview {
    CuentaView()
}
