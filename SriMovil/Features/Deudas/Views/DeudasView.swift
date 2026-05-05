//
//  DeudasView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 30/3/26.
//

import SwiftUI

struct DeudasView: View {
    
    // MARK: - Types
    
    enum TipoContribuyente: String, CaseIterable, Identifiable {
        case personaNatural = "Persona Natural"
        case sociedades = "Sociedades"
        
        var id: String { rawValue }
    }
    
    enum TipoDocumentoDeuda: String, CaseIterable, Identifiable {
        case ruc = "Número de RUC"
        case cedula = "Número de cédula"
        case apellidosYNombres = "Apellidos y Nombres"
        
        var id: String { rawValue }
        
        var helperText: String? {
            switch self {
            case .ruc:
                return "13 dígitos"
            case .cedula:
                return "10 dígitos"
            case .apellidosYNombres:
                return nil
            }
        }
        
        var placeholder: String {
            switch self {
            case .ruc:
                return "Ej: 1790012345001"
            case .cedula:
                return "Ej: 1712345678"
            case .apellidosYNombres:
                return ""
            }
        }
    }
    
    // MARK: - Properties
    
    @State private var tipoContribuyente: TipoContribuyente = .personaNatural
    @State private var tipoDocumento: TipoDocumentoDeuda = .ruc
    
    @State private var numeroDocumento = ""
    @State private var apellidos = ""
    @State private var nombres = ""
    
    @State private var lastQueriedValue = ""
    
    @State private var shouldNavigateToDetail = false
    
    // MARK: - State
    
    @State private var viewModel: DeudasViewModel
    
    // MARK: - Initializers
    
    init(interactor: DeudasInteractoProtocol = DeudasInteractor()) {
        self.viewModel = DeudasViewModel(interactor: interactor)
    }
    
    // MARK: - Computed Properties
    
    private var isInlineFieldError: Bool {
        viewModel.isInlineFieldError
    }
    
    private var trimmedNumeroDocumento: String {
        numeroDocumento.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var trimmedApellidos: String {
        apellidos.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var trimmedNombres: String {
        nombres.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var isDocumentValid: Bool {
        switch tipoDocumento {
        case .ruc:
            return trimmedNumeroDocumento.count == 13
        case .cedula:
            return trimmedNumeroDocumento.count == 10
        case .apellidosYNombres:
            return !trimmedApellidos.isEmpty
        }
    }
    
    private var isConsultButtonDisabled: Bool {
        !isDocumentValid || viewModel.isLoading
    }
    
    private var currentQueryIdentifier: String {
        switch tipoDocumento {
        case .ruc, .cedula:
            return trimmedNumeroDocumento
        case .apellidosYNombres:
            return "\(trimmedApellidos)|\(trimmedNombres)"
        }
    }
    
    private var consultButtonBackgroundColor: Color {
        isConsultButtonDisabled
        ? SRIColors.primary.opacity(0.35)
        : SRIColors.primary
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    formCard
                    contentSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 120)
            }
            .background(SRIBackgrounds.formGradient)
            .navigationTitle("Consulta de Deudas")
            .navigationBarTitleDisplayMode(.large)
            .safeAreaInset(edge: .bottom) {
                bottomActionBar
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationDestination(isPresented: $shouldNavigateToDetail) {
                if let deudas = viewModel.deudas {
                    DeudasDetailView(deudas: deudas)
                }
            }
            .alert(
                AppStrings.Error.title,
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil && viewModel.deudas != nil },
                    set: { if !$0 { viewModel.errorMessage = nil } }
                )
            ) {
                Button(AppStrings.Common.ok, role: .cancel) {
                    viewModel.errorMessage = nil
                }
                
                Button(AppStrings.Common.retry) {
                    consultarDeudas()
                }
            } message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
            .onAppear {
                viewModel.resetState()
                shouldNavigateToDetail = false
            }
            .onChange(of: numeroDocumento) { _, newValue in
                let filteredValue = filteredNumericDocument(from: newValue, for: tipoDocumento)
                
                if filteredValue != newValue {
                    numeroDocumento = filteredValue
                    return
                }
                
                clearStateIfNeeded()
            }
            .onChange(of: apellidos) { _, _ in
                clearStateIfNeeded()
            }
            .onChange(of: nombres) { _, _ in
                clearStateIfNeeded()
            }
            .onChange(of: tipoDocumento) { _, newValue in
                handleDocumentTypeChange(newValue)
            }
            .onChange(of: tipoContribuyente) { _, _ in
                resetQueryState()
            }
            .onChange(of: viewModel.deudas) { _, newValue in
                guard newValue != nil else { return }
                
                switch tipoDocumento {
                case .ruc, .cedula:
                    shouldNavigateToDetail = true
                case .apellidosYNombres:
                    break
                }
            }
        }
    }

    // MARK: - Sections
    
    private var formCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            contributorTypeSection
            documentCardSection
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(SRIColors.cardBackground)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(SRIColors.border.opacity(0.22), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.035), radius: 10, x: 0, y: 5)
    }
    
    private var contributorTypeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("TIPO DE CONTRIBUYENTE")
                .font(.caption.weight(.semibold))
                .tracking(0.8)
                .foregroundStyle(SRIColors.textSecondary)
            
            Picker("Tipo de contribuyente", selection: $tipoContribuyente) {
                ForEach(TipoContribuyente.allCases) { tipo in
                    Text(tipo.rawValue).tag(tipo)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    private var documentCardSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("TIPO DE DOCUMENTO")
                .font(.caption.weight(.semibold))
                .tracking(0.8)
                .foregroundStyle(SRIColors.textSecondary)
            
            Menu {
                ForEach(TipoDocumentoDeuda.allCases) { tipo in
                    Button {
                        tipoDocumento = tipo
                    } label: {
                        if tipo == tipoDocumento {
                            Label(tipo.rawValue, systemImage: "checkmark")
                        } else {
                            Text(tipo.rawValue)
                        }
                    }
                }
            } label: {
                HStack(spacing: 12) {
                    Text(tipoDocumento.rawValue)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(SRIColors.textPrimary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(SRIColors.textSecondary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 18)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(SRIColors.cardBackground)
                )
            }
            .buttonStyle(.plain)
            
            switch tipoDocumento {
            case .ruc, .cedula:
                singleDocumentFieldSection
            case .apellidosYNombres:
                namesFieldsSection
            }
            
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
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
    
    private var singleDocumentFieldSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text(tipoDocumento.rawValue.uppercased())
                    .font(.caption.weight(.semibold))
                    .tracking(0.8)
                    .foregroundStyle(SRIColors.textSecondary)
                
                Spacer()
                
                if let helperText = tipoDocumento.helperText {
                    Text(helperText)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(SRIColors.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule(style: .continuous)
                                .fill(SRIColors.primary.opacity(0.18))
                        )
                }
            }
            
            HStack(spacing: 12) {
                TextField(tipoDocumento.placeholder, text: $numeroDocumento)
                    .font(.body)
                    .foregroundStyle(SRIColors.textPrimary)
                    .keyboardType(.numberPad)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                Image(systemName: "circle.grid.3x3.fill")
                    .font(.caption)
                    .foregroundStyle(SRIColors.textSecondary.opacity(0.45))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(SRIColors.cardBackground)
                    .overlay {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(
                                isInlineFieldError
                                ? SRIColors.error
                                : SRIColors.border.opacity(0.55),
                                lineWidth: isInlineFieldError ? 1.5 : 1
                            )
                    }
            )
        }
    }
    
    private var namesFieldsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 6) {
                    Text("APELLIDOS")
                        .font(.caption.weight(.semibold))
                        .tracking(0.8)
                        .foregroundStyle(SRIColors.textSecondary)
                    
                    Text("*")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(SRIColors.error)
                }
                
                TextField("Ej: Pérez González", text: $apellidos)
                    .font(.title3.weight(.medium))
                    .foregroundStyle(SRIColors.textPrimary)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 16)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(SRIColors.cardBackground)
                            .overlay {
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .stroke(
                                        isInlineFieldError && trimmedApellidos.isEmpty
                                        ? SRIColors.error
                                        : SRIColors.border.opacity(0.55),
                                        lineWidth: isInlineFieldError && trimmedApellidos.isEmpty ? 1.5 : 1
                                    )
                            }
                    )
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 6) {
                    Text("NOMBRES")
                        .font(.caption.weight(.semibold))
                        .tracking(0.8)
                        .foregroundStyle(SRIColors.textSecondary)
                    
                    Text("(opcional)")
                        .font(.caption)
                        .foregroundStyle(SRIColors.textSecondary)
                }
                
                TextField("Ej: Juan Carlos", text: $nombres)
                    .font(.title3.weight(.medium))
                    .foregroundStyle(SRIColors.textPrimary)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 16)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(SRIColors.cardBackground)
                            .overlay {
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .stroke(
                                        SRIColors.border.opacity(0.55),
                                        lineWidth: 1
                                    )
                            }
                    )
            }
        }
    }
    
    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            loadingSection
        } else if let deudas = viewModel.deudas {
            DeudasResultadoView(deudas: deudas)
        } else if let errorMessage = viewModel.errorMessage, !isInlineFieldError {
            networkErrorView(message: errorMessage)
        } else {
            initialSection
        }
    }
    
    private var loadingSection: some View {
        VStack(spacing: 12) {
            ProgressView(AppStrings.Common.loading)
                .tint(SRIColors.primary)
            
            Text("Consultando obligaciones pendientes")
                .font(.subheadline)
                .foregroundStyle(SRIColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 12)
    }
    
    private var initialSection: some View {
        ContentUnavailableView(
            "Consulta disponible",
            systemImage: "doc.text.magnifyingglass",
            description: Text("Selecciona el tipo de documento e ingresa la información requerida para consultar tus deudas.")
                .foregroundStyle(SRIColors.textSecondary)
        )
        .frame(maxWidth: .infinity)
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
    
    private var bottomActionBar: some View {
        VStack(spacing: 0) {
            Divider()
                .opacity(0.08)
            
            Button {
                consultarDeudas()
            } label: {
                HStack(spacing: 10) {
                    Text("Consultar Deuda")
                        .font(.headline)
                    
                    Image(systemName: "arrow.right")
                        .font(.headline.weight(.semibold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(consultButtonBackgroundColor)
                )
            }
            .buttonStyle(.plain)
            .disabled(isConsultButtonDisabled)
            .transaction { transaction in
                transaction.animation = nil
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 12)
            .background(.ultraThinMaterial)
        }
    }
    
    // MARK: - Private Helpers
    
    private func consultarDeudas() {
        lastQueriedValue = currentQueryIdentifier
        
        Task {
            switch tipoDocumento {
            case .ruc, .cedula:
                await viewModel.obtenerDeudas(
                    tipoContribuyente: tipoContribuyente.rawValue,
                    tipoDocumento: tipoDocumento.rawValue,
                    numeroDocumento: trimmedNumeroDocumento,
                    apellidos: nil,
                    nombres: nil
                )
                
            case .apellidosYNombres:
                await viewModel.obtenerDeudas(
                    tipoContribuyente: tipoContribuyente.rawValue,
                    tipoDocumento: tipoDocumento.rawValue,
                    numeroDocumento: nil,
                    apellidos: trimmedApellidos,
                    nombres: trimmedNombres.isEmpty ? nil : trimmedNombres
                )
            }
        }
    }
    
    private func filteredNumericDocument(
        from value: String,
        for tipo: TipoDocumentoDeuda
    ) -> String {
        switch tipo {
        case .ruc:
            return String(value.filter(\.isNumber).prefix(13))
        case .cedula:
            return String(value.filter(\.isNumber).prefix(10))
        case .apellidosYNombres:
            return value
        }
    }
    
    private func handleDocumentTypeChange(_ newValue: TipoDocumentoDeuda) {
        switch newValue {
        case .ruc:
            numeroDocumento = String(numeroDocumento.filter(\.isNumber).prefix(13))
            apellidos = ""
            nombres = ""
            
        case .cedula:
            numeroDocumento = String(numeroDocumento.filter(\.isNumber).prefix(10))
            apellidos = ""
            nombres = ""
            
        case .apellidosYNombres:
            numeroDocumento = ""
        }
        
        resetQueryState()
    }
    
    private func clearStateIfNeeded() {
        guard currentQueryIdentifier != lastQueriedValue else { return }
        resetQueryState()
    }
    
    private func resetQueryState() {
        withAnimation(.easeInOut(duration: 0.22)) {
            viewModel.deudas = nil
            viewModel.errorMessage = nil
            viewModel.isInlineFieldError = false
            shouldNavigateToDetail = false
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

// MARK: - Resultado Placeholder

private struct DeudasResultadoView<DeudasData>: View {
    
    let deudas: DeudasData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Resultado de la consulta")
                .font(.title3.weight(.semibold))
                .foregroundStyle(SRIColors.textPrimary)
            
            VStack(alignment: .leading, spacing: 10) {
                Label("Consulta realizada correctamente", systemImage: "checkmark.seal.fill")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.green)
                
                Text("Aquí puedes renderizar el detalle de deudas usando el modelo que retorna tu servicio.")
                    .font(.subheadline)
                    .foregroundStyle(SRIColors.textSecondary)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(SRIColors.surface)
            )
        }
        .padding(.top, 8)
    }
}

// MARK: - Preview

#Preview {
    DeudasView()
}
