//
//  MatriculacionVehicularView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI
import Factory

enum ViewStack {
    case detalleVehiculoView
    case errorView
}

struct MatriculacionVehicularView: View {
    
    @Injected(\.matriculacionVehicularViewModel) private var viewModel: MatriculacionVehicularViewModel
    
    @State private var placa: String = ""
    @State private var infoVehiculo: InfoVehiculoModel?
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    @State private var siguienteView: ViewStack = .detalleVehiculoView
    @State private var isNavigating: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    TextField("Ingrese la placa", text: $placa)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: placa) {
                            placa = placa.uppercased()
                        }
                        .padding()
                    
                    ButtonPersonalizadoView(title: "Consultar", action: {
                        Task {
                            isLoading = true
                            await viewModel.obtenerInfoVehiculo(idVehiculo: placa)
                            isLoading = false
                            switch viewModel.estado {
                            case .cargado(let info):
                                infoVehiculo = info
                                siguienteView = .detalleVehiculoView
                                isNavigating = true
                            case .error(let error):
                                errorMessage = error
                                siguienteView = .errorView
                                isNavigating = true
                            default:
                                break
                            }
                        }
                    })
                    .padding()
                    .disabled(placa.isEmpty)
                    
                    Spacer()
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
                    isActive: $isNavigating,
                    label: { EmptyView() }
                )
            )
        }
    }
    
    
    private func destinationView() -> some View {
        Group {
            switch siguienteView {
            case .detalleVehiculoView:
                MatriculacionVehicularDetalleView(infoVehiculo: infoVehiculo)
            case .errorView:
                ErrorView(message: errorMessage!)
            }
        }
    }
}



#Preview {
    MatriculacionVehicularView()
}
