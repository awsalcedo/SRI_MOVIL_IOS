//
//  MatriculacionVehicularView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct MatriculacionVehicularView: View {
    
    // MARK: - Propiedades
    
    @State private var placa: String = ""
    @State private var lastQueriedVehiculo = ""
    
    // MARK: - State
    
    @State private var viewModel: MatriculacionVehicularViewModel
    
    // MARK: - Inicializadores
    
    init(interactor: MatriculacionVehicularInteractorProtocol = MatriculacionVehicularInteractor()) {
        self.viewModel = MatriculacionVehicularViewModel(interactor: interactor)
    }
    
    // MARK: - Propiedades Computadas
    
    private var isConsultButtonDisabled: Bool {
            placa.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading
        }
    
    private var isLoading: Bool {
            if case .loading = viewModel.state {
                return true
            }
            return false
        }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
                    ScrollView {
                        VStack(spacing: 24) {
                            inputSection
                            contentSection
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                        .padding(.bottom, 32)
                    }
                    .background(SRIColors.background)
                    .navigationTitle("Valores a pagar")
                    .toolbarTitleDisplayMode(.inline)
                    .onAppear {
                        viewModel.resetState()
                    }
                    .onChange(of: placa) { _, newValue in
                        let trimmedValue = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        guard trimmedValue != lastQueriedVehiculo else { return }
                        
                        withAnimation(.easeInOut(duration: 0.22)) {
                            viewModel.resetState()
                        }
                    }
                }
    }
    
    // MARK: - Views Privadas
    
    private var inputSection: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("Placa, RAMV o CPN")
                    .font(.headline)
                    .foregroundStyle(SRIColors.textPrimary)
                
                CustomTextFieldView(
                    texto: $placa,
                    placeholder: "Ej: AAA0123",
                    icono: "car.fill"
                ) {
                    consultar()
                }
                
                if case .failure(let message, let isInlineFieldError) = viewModel.state,
                   isInlineFieldError {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "exclamationmark.circle.fill")
                            .font(.footnote)
                            .foregroundStyle(SRIColors.error)
                        
                        Text(message)
                            .font(.footnote)
                            .foregroundStyle(SRIColors.error)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                Button {
                    consultar()
                } label: {
                    Text("Consultar")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(
                                    isConsultButtonDisabled
                                    ? SRIColors.textSecondary.opacity(0.6)
                                    : SRIColors.primary
                                )
                        )
                }
                .buttonStyle(.plain)
                .disabled(isConsultButtonDisabled)
                .opacity(isConsultButtonDisabled ? 0.5 : 1)
            }
        }
    
    @ViewBuilder
        private var contentSection: some View {
            switch viewModel.state {
            case .idle:
                initialSection
                
            case .loading:
                loadingSection
                
            case .success(let infoVehiculo):
                DetalleMatriculacionView(infoVehiculo: infoVehiculo)
                
            case .failure(let message, let isInlineFieldError):
                if isInlineFieldError {
                    EmptyView()
                } else {
                    networkErrorView(message: message)
                }
            }
        }
    
    private var loadingSection: some View {
            VStack(spacing: 12) {
                ProgressView(AppStrings.Common.loading)
                    .tint(SRIColors.primary)
                
                Text("Consultando información del vehículo")
                    .font(.subheadline)
                    .foregroundStyle(SRIColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 24)
        }
        
        private var initialSection: some View {
            VStack(spacing: 12) {
                Image(systemName: "car.circle")
                    .font(.system(size: 36))
                    .foregroundStyle(SRIColors.textSecondary)
                
                Text("Ingresa una placa, RAMV o CPN para consultar los valores a pagar")
                    .font(.subheadline)
                    .foregroundStyle(SRIColors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 32)
        }
    
    private func networkErrorView(message: String) -> some View {
            ContentUnavailableView(
                AppStrings.Error.title,
                systemImage: errorIcon(for: message),
                description: Text(message)
                    .foregroundStyle(SRIColors.textPrimary)
            )
            .frame(maxWidth: .infinity)
            .padding(.top, 24)
        }
    
    // MARK: - Funciones Privadas
        
        private func consultar() {
            lastQueriedVehiculo = placa.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Task {
                await viewModel.obtenerInfoVehiculo(idVehiculo: placa)
            }
        }
        
        private func errorIcon(for message: String) -> String {
            switch message {
            case AppStrings.Error.network:
                return "wifi.exclamationmark"
            case AppStrings.Error.timeout:
                return "clock.badge.exclamationmark"
            default:
                return "exclamationmark.triangle"
            }
        }
    
}


#Preview {
    MatriculacionVehicularView()
}
