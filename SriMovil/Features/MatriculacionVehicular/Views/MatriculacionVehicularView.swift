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
    
    private var trimmedPlaca: String {
        placa.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var isLoading: Bool {
        if case .loading = viewModel.state { return true }
        return false
    }
    
    private var isConsultButtonDisabled: Bool {
        trimmedPlaca.isEmpty || isLoading
    }
    
    private var inlineErrorMessage: String? {
        guard case .failure(let message, let isInlineFieldError) = viewModel.state,
              isInlineFieldError else {
            return nil
        }
        return message
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                heroSection
                statusSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 32)
        }
        .background(SRIColors.background.ignoresSafeArea())
        .navigationTitle("Valores a pagar")
        .navigationBarTitleDisplayMode(.inline)
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
    
    // MARK: - Sections
    
    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            heroHeader
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Identificador del vehículo")
                    .font(.headline)
                    .foregroundStyle(SRIColors.textPrimary)
                
                SRITextFieldButtonView(
                    texto: $placa,
                    placeholder: "Ej: AAA0123",
                    icono: "car.fill",
                    inputMode: .alphanumeric(maxLength: 20, uppercase: true),
                    hasValidationError: inlineErrorMessage != nil
                )
                
                if let inlineErrorMessage {
                    InlineErrorMessageView(message: inlineErrorMessage)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
                
                Button {
                    consultar()
                } label: {
                    HStack(spacing: 10) {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Image(systemName: "magnifyingglass")
                                .font(.headline)
                        }
                        
                        Text(isLoading ? "Consultando…" : "Consultar valores")
                            .font(.headline)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(
                                isConsultButtonDisabled
                                ? SRIColors.primary.opacity(0.35)
                                : SRIColors.primary
                            )
                    )
                }
                .buttonStyle(.plain)
                .disabled(isConsultButtonDisabled)
                .opacity(isConsultButtonDisabled ? 0.9 : 1)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(SRIColors.border.opacity(0.35), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.04), radius: 10, y: 4)
    }
    
    private var heroHeader: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                Circle()
                    .fill(SRIColors.primary.opacity(0.12))
                    .frame(width: 44, height: 44)
                
                Image(systemName: "car.circle.fill")
                    .font(.title3)
                    .foregroundStyle(SRIColors.primary)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Consulta vehicular")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(SRIColors.textPrimary)
                
                Text("Ingresa la placa, RAMV o CPN para consultar valores pendientes y acceder al detalle del vehículo.")
                    .font(.subheadline)
                    .foregroundStyle(SRIColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    @ViewBuilder
    private var statusSection: some View {
        switch viewModel.state {
        case .idle:
            MatriculacionEmptyStateView()
                .transition(.opacity)
            
        case .loading:
            MatriculacionLoadingStateView()
                .transition(.opacity)
            
        case .success(let infoVehiculo):
            MatriculacionVehicularDetalleView(infoVehiculo: infoVehiculo)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            
        case .failure(let message, let isInlineFieldError):
            if isInlineFieldError {
                MatriculacionEmptyStateView()
                    .transition(.opacity)
            } else {
                networkErrorView(message: message)
                    .transition(.opacity)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func consultar() {
        lastQueriedVehiculo = trimmedPlaca
        
        Task {
            await viewModel.obtenerInfoVehiculo(idVehiculo: trimmedPlaca)
        }
    }
    
    private func networkErrorView(message: String) -> some View {
        ContentUnavailableView(
            AppStrings.Error.title,
            systemImage: errorIcon(for: message),
            description: Text(message)
                .foregroundStyle(SRIColors.textPrimary)
        )
        .frame(maxWidth: .infinity)
        .padding(.top, 12)
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
    NavigationStack {
        MatriculacionVehicularView()
    }
}
