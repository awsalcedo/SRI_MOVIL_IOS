//
//  MatriculacionVehicularView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct MatriculacionVehicularView: View {
    
    @State private var placa: String = ""
    @State private var viewModel = MatriculacionVehicularViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    HStack {
                        Text("Placa, RAMV o CPN:")
                        Spacer()
                    }
                    
                    CustomTextFieldView(texto: $placa, placeholder: "Ej: AAA0123", icono: "car.fill") {
                        Task {
                            await viewModel.obtenerInfoVehiculo(idVehiculo: placa)
                        }
                    }
                    
                    Spacer()
                    
                    // Manejar los diferentes estados
                    switch viewModel.vehiculoState {
                    case .idle:
                        EmptyView()
                    case .loading:
                        BarraProgresoView()
                    case .success(let infoVehiculo):
                        //MatriculacionVehicularDetalleView(infoVehiculo: infoVehiculo)
                        DetalleMatriculacionView(infoVehiculo: infoVehiculo)
                    case .failure(let errorMessage):
                        ErrorView(error: errorMessage)
                        Spacer()
                    }
                }
                .padding()
            }
            .navigationTitle("Valores a pagar")
            .toolbarTitleDisplayMode(.inline)
        }
    }
    
}


#Preview {
    MatriculacionVehicularView()
}
