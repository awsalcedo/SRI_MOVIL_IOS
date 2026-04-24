//
//  LoginView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import SwiftUI

/// Pantalla principal de autenticación de SRI Móvil.
///
/// Esta vista presenta el flujo de login de la aplicación y adapta
/// su contenido según el estado actual del usuario:
/// - no identificado,
/// - identificado pero no autenticado,
/// - identificado y autenticado.
///
/// La vista se integra con `LoginViewModel` y utiliza materiales del sistema
/// para ofrecer una apariencia contemporánea, ligera y visualmente cercana
/// al lenguaje nativo de iOS.
struct LoginView: View {
    
    // MARK: - Focus
    
    /// Define los campos enfocables de la pantalla de login.
    private enum Field: Hashable {
        case identificacion
        case ciAdicional
        case contrasena
    }
    
    // MARK: - Properties
    
    @State private var viewModel: LoginViewModel
    @Environment(\.openURL) private var openURL
    @FocusState private var focusedField: Field?
    
    // MARK: - Initializers
    
    /// Crea una nueva instancia de la pantalla de login.
    ///
    /// - Parameter viewModel: ViewModel que coordina la lógica de presentación.
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
    }
    
    // MARK: - Computed Properties
    
    private var isLoading: Bool {
        if case .loading = viewModel.state { return true }
        return false
    }
    
    private var screenModel: LoginScreenModel {
        if case .success(let model) = viewModel.state {
            return model
        }
        
        return LoginScreenModel(
            identificado: false,
            autenticado: false,
            identificacionContribuyente: nil,
            razonSocialContribuyente: nil
        )
    }
    
    private var inlineErrorMessage: String? {
        guard case .failure(let message, let isInlineFieldError) = viewModel.state,
              isInlineFieldError else {
            return nil
        }
        return message
    }
    
    private var generalErrorMessage: String? {
        guard case .failure(let message, let isInlineFieldError) = viewModel.state,
              !isInlineFieldError else {
            return nil
        }
        return message
    }
    
    private var isSubmitDisabled: Bool {
        if isLoading { return true }
        
        if screenModel.identificado && !screenModel.autenticado {
            return viewModel.contrasena.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        
        return viewModel.identificacion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        || viewModel.contrasena.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var shouldShowAnonymousForm: Bool {
        !screenModel.identificado
    }
    
    private var shouldShowPasswordOnlyForm: Bool {
        screenModel.identificado && !screenModel.autenticado
    }
    
    private var shouldShowAuthenticatedProfile: Bool {
        screenModel.identificado && screenModel.autenticado
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    Spacer(minLength: 20)
                    loginCard
                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                .contentShape(Rectangle())
                .onTapGesture {
                    dismissKeyboard()
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .background(backgroundView.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .task {
                viewModel.loadStoredSession()
            }
            .onChange(of: focusedField) { _, newValue in
                guard let newValue else { return }
                
                withAnimation(.easeInOut(duration: 0.22)) {
                    proxy.scrollTo(newValue, anchor: .center)
                }
            }
        }
    }
    
    // MARK: - Sections
    
    private var loginCard: some View {
        VStack(spacing: 22) {
            brandSection
            
            if let generalErrorMessage {
                LoginStatusMessageView(
                    message: generalErrorMessage,
                    kind: .errorSystem,
                    action: errorAction(for: generalErrorMessage)
                )
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
            
            if shouldShowAnonymousForm {
                anonymousFormSection
                    .transition(.opacity)
            }
            
            if shouldShowPasswordOnlyForm {
                identifiedFormSection
                    .transition(.opacity)
            }
            
            if shouldShowAuthenticatedProfile {
                authenticatedSection
                    .transition(.opacity)
            }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 28)
        .background(cardBackground)
        .overlay(cardBorder)
        .shadow(color: .black.opacity(0.05), radius: 18, y: 8)
        .animation(.easeInOut(duration: 0.22), value: viewModel.state)
    }
    
    private var brandSection: some View {
        VStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(SRIColors.primary)
                    .frame(width: 72, height: 72)
                    .shadow(color: SRIColors.primary.opacity(0.22), radius: 10, y: 5)
                
                Image(systemName: "building.columns.fill")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(.white)
            }
            
            VStack(spacing: 4) {
                Text("SRI Móvil")
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .foregroundStyle(SRIColors.textPrimary)
                
                Text("Servicio de Rentas Internas")
                    .font(.subheadline)
                    .foregroundStyle(SRIColors.textSecondary)
            }
        }
        .padding(.bottom, 6)
    }
    
    private var anonymousFormSection: some View {
        VStack(spacing: 16) {
            formFieldsGroup {
                LoginFieldCard(
                    title: "IDENTIFICACIÓN",
                    placeholder: "RUC / C.I. / Pasaporte",
                    text: Binding(
                        get: { viewModel.identificacion },
                        set: { viewModel.identificacion = $0 }
                    ),
                    keyboardType: .asciiCapable,
                    textContentType: .username,
                    submitLabel: .next,
                    inputMode: .uppercase,
                    isFocused: focusedField == .identificacion,
                    onTap: { focusedField = .identificacion }
                )
                .focused($focusedField, equals: .identificacion)
                .id(Field.identificacion)
                .onSubmit {
                    focusedField = .contrasena
                }
                
                LoginFieldCard(
                    title: "C.I. ADICIONAL",
                    placeholder: "Opcional",
                    text: Binding(
                        get: { viewModel.ciAdicional },
                        set: { viewModel.ciAdicional = $0 }
                    ),
                    keyboardType: .numberPad,
                    textContentType: .none,
                    submitLabel: .next,
                    inputMode: .digits,
                    isFocused: focusedField == .ciAdicional,
                    onTap: { focusedField = .ciAdicional }
                )
                .focused($focusedField, equals: .ciAdicional)
                .id(Field.ciAdicional)
                .onSubmit {
                    focusedField = .contrasena
                }
                
                LoginPasswordFieldCard(
                    title: "CONTRASEÑA",
                    placeholder: "••••••••",
                    text: Binding(
                        get: { viewModel.contrasena },
                        set: { viewModel.contrasena = $0 }
                    ),
                    isPasswordVisible: Binding(
                        get: { viewModel.isPasswordVisible },
                        set: { viewModel.isPasswordVisible = $0 }
                    ),
                    isFocused: focusedField == .contrasena,
                    onTap: { focusedField = .contrasena },
                    onSubmit: {
                        dismissKeyboard()
                        
                        if !isSubmitDisabled {
                            Task {
                                await viewModel.autenticar()
                            }
                        }
                    }
                )
                .focused($focusedField, equals: .contrasena)
                .id(Field.contrasena)
            }
            
            if let inlineErrorMessage {
                LoginStatusMessageView(
                    message: inlineErrorMessage,
                    kind: .inlineError,
                    action: errorAction(for: inlineErrorMessage)
                )
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
            
            LoginPrimaryButton(
                title: isLoading ? "Ingresando…" : "Ingresar",
                isLoading: isLoading,
                isEnabled: !isSubmitDisabled
            ) {
                dismissKeyboard()
                
                Task {
                    await viewModel.autenticar()
                }
            }
        }
    }
    
    private var identifiedFormSection: some View {
        VStack(spacing: 18) {
            LoginProfileCard(
                title: "Perfil",
                identificacion: screenModel.identificacionContribuyente ?? "",
                razonSocial: screenModel.razonSocialContribuyente ?? ""
            )
            
            VStack(spacing: 16) {
                formFieldsGroup {
                    LoginPasswordFieldCard(
                        title: "CONTRASEÑA",
                        placeholder: "••••••••",
                        text: Binding(
                            get: { viewModel.contrasena },
                            set: { viewModel.contrasena = $0 }
                        ),
                        isPasswordVisible: Binding(
                            get: { viewModel.isPasswordVisible },
                            set: { viewModel.isPasswordVisible = $0 }
                        ),
                        isFocused: focusedField == .contrasena,
                        onTap: { focusedField = .contrasena },
                        onSubmit: {
                            dismissKeyboard()
                            
                            if !isSubmitDisabled {
                                Task {
                                    await viewModel.autenticar()
                                }
                            }
                        }
                    )
                    .focused($focusedField, equals: .contrasena)
                    .id(Field.contrasena)
                }
                
                if let inlineErrorMessage {
                    LoginStatusMessageView(
                        message: inlineErrorMessage,
                        kind: .inlineError,
                        action: errorAction(for: inlineErrorMessage)
                    )
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
                
                LoginPrimaryButton(
                    title: isLoading ? "Ingresando…" : "Ingresar",
                    isLoading: isLoading,
                    isEnabled: !isSubmitDisabled
                ) {
                    dismissKeyboard()
                    
                    Task {
                        await viewModel.autenticar()
                    }
                }
                
                secondaryActions
            }
        }
    }
    
    private var authenticatedSection: some View {
        VStack(spacing: 18) {
            LoginProfileCard(
                title: "Perfil",
                identificacion: screenModel.identificacionContribuyente ?? "",
                razonSocial: screenModel.razonSocialContribuyente ?? ""
            )
            
            VStack(spacing: 12) {
                LoginPrimaryButton(
                    title: "Cerrar sesión",
                    isLoading: false,
                    isEnabled: true
                ) {
                    dismissKeyboard()
                    viewModel.cerrarSesion()
                }
                
                Button {
                    dismissKeyboard()
                    viewModel.cambiarUsuario()
                } label: {
                    Text("Cambiar de usuario")
                        .font(.headline)
                        .foregroundStyle(SRIColors.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(.ultraThinMaterial)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(SRIColors.primary.opacity(0.18), lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private var secondaryActions: some View {
        Button {
            dismissKeyboard()
            viewModel.cambiarUsuario()
        } label: {
            Text("Cambiar de usuario")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(SRIColors.primary)
        }
        .buttonStyle(.plain)
        .padding(.top, 2)
    }
    
    // MARK: - Backgrounds
    
    private var backgroundView: some View {
        LinearGradient(
            colors: [
                SRIColors.background,
                Color(.systemGroupedBackground)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.ultraThinMaterial)
            .background(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color(.secondarySystemBackground).opacity(0.82))
            )
    }
    
    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .strokeBorder(Color.white.opacity(0.45), lineWidth: 1)
    }
    
    // MARK: - Helpers
    
    @ViewBuilder
    private func formFieldsGroup<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 1) {
            content()
        }
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color(.systemBackground).opacity(0.55))
        )
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(SRIColors.border.opacity(0.22), lineWidth: 1)
        )
    }
    
    private func errorAction(for message: String) -> LoginStatusMessageAction? {
        if message.localizedCaseInsensitiveContains("bloqueada") {
            return .button(
                title: "Recuperar clave",
                action: {
                    if let url = URL(string: "https://srienlinea.sri.gob.ec/sri-en-linea/SriClaves/Recuperacion/clave") {
                        openURL(url)
                    }
                }
            )
        }
        
        if message.localizedCaseInsensitiveContains("actualizar")
            || message.localizedCaseInsensitiveContains("caducada")
            || message.localizedCaseInsensitiveContains("actualice su clave") {
            return .button(
                title: "Actualizar clave",
                action: {
                    if let url = URL(string: "https://srienlinea.sri.gob.ec/auth/realms/Internet/protocol/openid-connect/auth?client_id=app-sri-claves-angular&redirect_uri=https%3A%2F%2Fsrienlinea.sri.gob.ec%2Fsri-en-linea%2F%2Fcontribuyente%2Fperfil&state=70ffc0c1-d73d-4f56-9314-f263f4e8ffce&nonce=1518a326-69ea-4d93-9e92-342ac3a65147&response_mode=fragment&response_type=code&scope=openid") {
                        openURL(url)
                    }
                }
            )
        }
        
        return nil
    }
    
    private func dismissKeyboard() {
        focusedField = nil
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
