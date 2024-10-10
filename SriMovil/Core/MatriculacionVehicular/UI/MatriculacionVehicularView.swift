//
//  MatriculacionVehicularView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI
import Factory

enum ViewStackToast: Hashable {
    case detalleVehiculoView
    case errorView
}

struct MatriculacionVehicularView: View {
    
    @Injected(\.matriculacionVehicularViewModel) private var viewModel
    
    @State private var placa: String = ""
    @State private var isLoading: Bool = false
    @State private var siguienteView: ViewStackToast?
    
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
                            //await viewModel.obtenerInfoVehiculo(idVehiculo: placa)
                            isLoading = false
                            updateView()
                        }
                    })
                    .padding()
                    .disabled(placa.isEmpty)
                    
                    Spacer()
                }
                .padding()
                
                if isLoading {
                    BarraProgresoView()
                }
            }
            .navigationTitle("Valores a pagar")
            .toolbarTitleDisplayMode(.inline)
            .background(
                NavigationLink(
                    destination: destinationView(),
                    tag: ViewStackToast.detalleVehiculoView,
                    selection: $siguienteView,
                    label: { EmptyView() }
                ).hidden()
            )
            .background(
                NavigationLink(
                    destination: destinationView(),
                    tag: ViewStackToast.errorView,
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
        case .error:
            siguienteView = .errorView
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


#Preview {
    MatriculacionVehicularView()
}
