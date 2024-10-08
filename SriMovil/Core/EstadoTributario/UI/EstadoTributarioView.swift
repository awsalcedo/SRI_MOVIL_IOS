//
//  EstadoTributarioView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct EstadoTributarioView: View {
    @State private var ruc: String = ""
    @State private var viewModel = EstadoTributarioViewModel()
    
    var body: some View {
        VStack {
            TextField("Ingresa el RUC", text: $ruc)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Obtener Estado Tributario") {
                Task {
                    await viewModel.obtenerEstadoTributario(ruc: ruc)
                }
            }
            .padding()
            
            if let estado = viewModel.estadoTributario {
                Text("Razón Social: \(estado.razonSocial)")
                Text("Descripción: \(estado.descripcion)")
            } else if let error = viewModel.errores {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    EstadoTributarioView()
}
