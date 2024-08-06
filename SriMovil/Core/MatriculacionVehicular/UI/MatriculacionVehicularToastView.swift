//
//  MatriculacionVehicularToastView.swift
//  SriMovil
//
//  Created by usradmin on 6/8/24.
//

import SwiftUI
import Factory

struct MatriculacionVehicularToastView: View {
    @Injected(\.matriculacionVehicularViewModel) private var viewModel
    
    @State private var placa: String = ""
    @State private var isLoading: Bool = false
    @State private var siguienteView: ViewStack?
    @State private var showToast: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    HStack {
                        Text("Placa, RAMV o CPN:")
                        Spacer()
                    }
                    
                    CustomTextFieldView(texto: $placa, placeholder: "Ej: AAA0123", icono: "car.fill")
                    
                    ButtonPersonalizadoView(title: "Consultar", action: {
                        Task {
                            isLoading = true
                            await viewModel.obtenerInfoVehiculo(idVehiculo: placa)
                            isLoading = false
                            updateView()
                        }
                    })
                    .padding()
                    .disabled(placa.isEmpty)
                    
                    Spacer()
                }
                .padding()
                .overlay(
                    ToastView(message: errorMessage, isShowing: $showToast)
                )
                .onAppear {
                    // Reset toast state when the view appears
                    showToast = false
                }
                
                if isLoading {
                    BarraProgresoView()
                }
            }
            .navigationTitle("Valores a pagar")
            .toolbarTitleDisplayMode(.inline)
            .background(
                NavigationLink(
                    destination: destinationView(),
                    tag: ViewStack.detalleVehiculoView,
                    selection: $siguienteView,
                    label: { EmptyView() }
                ).hidden()
            )
            .background(
                NavigationLink(
                    destination: destinationView(),
                    tag: ViewStack.errorView,
                    selection: $siguienteView,
                    label: { EmptyView() }
                ).hidden()
            )
        }
    }
    
    private func updateView() {
        switch viewModel.estado {
        case .cargado:
            siguienteView = .detalleVehiculoView
        case .error(let error):
            errorMessage = error.localizedDescription
            showToast = true
        default:
            break
        }
    }
    
    @ViewBuilder
    private func destinationView() -> some View {
        switch siguienteView {
        case .detalleVehiculoView:
            if case .cargado(let infoVehiculo) = viewModel.estado {
                MatriculacionVehicularDetalleView(infoVehiculo: infoVehiculo)
            } else {
                EmptyView()
            }
        case .errorView:
            if case .error(let error) = viewModel.estado {
                ErrorView(error: error)
            } else {
                EmptyView()
            }
        default:
            EmptyView()
        }
    }
}


struct MatriculacionVehicularToastView_Previews: PreviewProvider {
    static var previews: some View {
        MatriculacionVehicularToastView()
    }
}


