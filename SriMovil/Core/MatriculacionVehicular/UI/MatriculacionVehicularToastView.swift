//
//  MatriculacionVehicularToastView.swift
//  SriMovil
//
//  Created by usradmin on 6/8/24.
//

import SwiftUI
import Factory

struct MatriculacionVehicularToastView: View {
    @Injected(\.matriculacionVehicularViewModel) private var viewModel: MatriculacionVehicularViewModel
    
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
            .navigationDestination(for: ViewStack?.self) { view in
                if let view = view {
                    destinationView(for: view)
                }
            }
        }
        .onChange(of: siguienteView) { newValue in
            print("siguienteView changed to \(String(describing: newValue))")
        }
    }
    
    private func updateView() {
        switch viewModel.estado {
        case .cargado:
            siguienteView = .detalleVehiculoView
            print("Estado: cargado, siguienteView set to .detalleVehiculoView")
        case .error(let error):
            errorMessage = error.localizedDescription
            showToast = true
            print("Estado: error, errorMessage set to \(error.localizedDescription)")
        default:
            break
        }
    }
    
    @ViewBuilder
    private func destinationView(for view: ViewStack) -> some View {
        switch view {
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
        }
    }
}


struct MatriculacionVehicularToastView_Previews: PreviewProvider {
    static var previews: some View {
        MatriculacionVehicularToastView()
    }
}


