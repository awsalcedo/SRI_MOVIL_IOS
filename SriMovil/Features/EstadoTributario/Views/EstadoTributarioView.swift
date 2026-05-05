//
//  EstadoTributarioView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct EstadoTributarioView: View {
    
    // MARK: - Properties
    
    @State private var ruc = ""
    @State private var lastQueriedRuc = ""
    
    // MARK: - State
    
    @State private var viewModel: EstadoTributarioViewModel
    
    // MARK: - Initializers
    
    init(interactor: EstadoTributarioInteractorProtocol = EstadoTributarioInteractor()) {
        self.viewModel = EstadoTributarioViewModel(interactor: interactor)
    }
    
    // MARK: - Computed Properties
    
    private var isInlineFieldError: Bool {
        viewModel.isInlineFieldError
    }
    
    private var isConsultButtonDisabled: Bool {
        ruc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading
    }
    
    private var consultButtonBackgroundColor: Color {
        ruc.count == 13
        ? SRIColors.primary
        : SRIColors.primary.opacity(0.35)
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    inputSection
                    
                    if viewModel.isLoading {
                        loadingSection
                    } else if let estadoTributario = viewModel.estadoTributario {
                        EstadoTributarioDetalleView(infoEstadoTributario: estadoTributario)
                    } else if let errorMessage = viewModel.errorMessage, !isInlineFieldError {
                        networkErrorView(message: errorMessage)
                    } else if viewModel.errorMessage == nil {
                        initialSection
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 32)
            }
            .background(SRIBackgrounds.formGradient)
            .scrollIndicators(.hidden)
            .navigationTitle("Estado Tributario")
            .toolbarTitleDisplayMode(.inline)
            .alert(
                AppStrings.Error.title,
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil && viewModel.estadoTributario != nil },
                    set: { if !$0 { viewModel.errorMessage = nil } }
                )
            ) {
                Button(AppStrings.Common.ok, role: .cancel) {
                    viewModel.errorMessage = nil
                }
                
                Button(AppStrings.Common.retry) {
                    Task {
                        await viewModel.obtenerEstadoTributario(ruc: ruc)
                    }
                }
            } message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
            .onAppear {
                viewModel.resetState()
            }
            .onChange(of: ruc) { _, newValue in
                let trimmedValue = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                
                guard trimmedValue != lastQueriedRuc else { return }
                
                withAnimation(.easeInOut(duration: 0.22)) {
                    viewModel.estadoTributario = nil
                    viewModel.errorMessage = nil
                    viewModel.isInlineFieldError = false
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    private var inputSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("RUC")
                .font(.headline)
                .foregroundStyle(SRIColors.textPrimary)
            
            SRITextFieldButtonView(
                texto: $ruc,
                placeholder: "Ej: 1700000000001",
                icono: "creditcard.fill",
                inputMode: .numeric(maxLength: 13),
                hasValidationError: isInlineFieldError
            )
            
            if isInlineFieldError, let errorMessage = viewModel.errorMessage {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.footnote)
                        .foregroundStyle(SRIColors.error)
                    
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundStyle(SRIColors.error)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            
            Button {
                lastQueriedRuc = ruc.trimmingCharacters(in: .whitespacesAndNewlines)
                Task {
                    await viewModel.obtenerEstadoTributario(ruc: ruc)
                }
            } label: {
                Text("Consultar")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(consultButtonBackgroundColor)
                    )
            }
            .buttonStyle(.plain)
            .disabled(ruc.count != 13)
            .transaction { transaction in
                transaction.animation = nil
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(SRIColors.cardBackground)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(SRIColors.border.opacity(0.22), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.035), radius: 10, x: 0, y: 5)
    }
    
    private var loadingSection: some View {
        VStack(spacing: 12) {
            ProgressView(AppStrings.Common.loading)
                .tint(SRIColors.primary)
            
            Text("Consultando información del contribuyente")
                .font(.subheadline)
                .foregroundStyle(SRIColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 24)
    }
    
    private var initialSection: some View {
        VStack(spacing: 12) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 36))
                .foregroundStyle(SRIColors.textSecondary)
            
            Text("Ingresa un RUC para consultar el estado tributario")
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
    
    // MARK: - Private Functions
    
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

// MARK: - Preview

#Preview {
    EstadoTributarioView()
}
