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
        
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Text("RUC:")
                        CustomTextFieldButtonView(texto: $ruc, placeholder: "Ej: 1700000000001", icono: "creditcard.fill") {
                            Task {
                                await viewModel.obtenerEstadoTributario(ruc: ruc)
                            }
                        }
                        //Spacer()
                    }
                    
                    /*CustomTextFieldView(texto: $ruc, placeholder: "Ej: 1700000000001", icono: "creditcard.fill")
                     
                     ButtonPersonalizadoView(title: "Consultar", action: {
                     Task {
                     
                     await viewModel.obtenerEstadoTributario(ruc: ruc)
                     
                     }
                     })
                     .padding()
                     .disabled(ruc.isEmpty)*/
                    
                    
                    /*CustomTextFieldButtonView(texto: $ruc, placeholder: "Ej: 1700000000001", icono: "creditcard.fill") {
                        Task {
                            await viewModel.obtenerEstadoTributario(ruc: ruc)
                        }
                    }*/
                    
                    
                    Spacer()
                    
                    // Manejar los diferentes estados
                    switch viewModel.estadoTributarioState {
                    case .idle:
                        EmptyView()
                    case .loading:
                        BarraProgresoView()
                    case .success(let estadoTributario):
                        // Cuando la llamada es exitosa, pasamos el modelo y navegamos
                        EstadoTributarioDetalleView(infoEstadoTributario: estadoTributario!)
                    case .failure(let errorMessage):
                        // Mostrar mensaje de error
                        ErrorView(error: errorMessage)
                        Spacer()
                    }
                }
                .padding()
            }
            .navigationTitle("Estado Tributario")
            .toolbarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.resetState()
        }
    }
}

#Preview {
    EstadoTributarioView()
}
