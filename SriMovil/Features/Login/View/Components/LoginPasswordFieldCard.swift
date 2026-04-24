//
//  LoginPasswordFieldCard.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import SwiftUI

/// Campo seguro reutilizable para la pantalla de login.
///
/// Este componente permite alternar entre mostrar y ocultar la contraseña
/// utilizando controles nativos de SwiftUI.
struct LoginPasswordFieldCard: View {
    
    let title: String
    let placeholder: String
    @Binding var text: String
    @Binding var isPasswordVisible: Bool
    let isFocused: Bool
    let onTap: () -> Void
    let onSubmit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(SRIColors.textSecondary.opacity(0.72))
                .tracking(0.8)
            
            HStack(spacing: 12) {
                if isPasswordVisible {
                    TextField(
                        "",
                        text: $text,
                        prompt: Text(placeholder)
                            .font(.callout)
                            .foregroundStyle(SRIColors.textSecondary.opacity(0.92))
                    )
                    .keyboardType(.asciiCapable)
                    .textInputAutocapitalization(.never)
                    .textContentType(.none)
                    .autocorrectionDisabled()
                    .font(.callout.weight(.medium))
                    .foregroundStyle(SRIColors.textPrimary)
                    .onSubmit(onSubmit)
                } else {
                    SecureField(
                        "",
                        text: $text,
                        prompt: Text(placeholder)
                            .font(.callout)
                            .foregroundStyle(SRIColors.textSecondary.opacity(0.92))
                    )
                    .keyboardType(.asciiCapable)
                    .textInputAutocapitalization(.never)
                    .textContentType(.password)
                    .autocorrectionDisabled()
                    .font(.callout.weight(.medium))
                    .foregroundStyle(SRIColors.textPrimary)
                    .onSubmit(onSubmit)
                }
                
                Button {
                    isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .font(.title3)
                        .foregroundStyle(SRIColors.primary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isPasswordVisible ? "Ocultar contraseña" : "Mostrar contraseña")
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(.systemBackground).opacity(0.95))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(
                        isFocused
                        ? SRIColors.primary
                        : SRIColors.border.opacity(0.45),
                        lineWidth: isFocused ? 1.5 : 1
                    )
            )
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.clear)
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
    }
}

#Preview("Password Field") {
    VStack(spacing: 20) {
        
        // Estado oculto (SecureField)
        LoginPasswordFieldCardPreviewWrapper(
            title: "CONTRASEÑA",
            placeholder: "••••••••",
            initialText: "Clave123@",
            isVisible: false
        )
        
        // Estado visible (TextField)
        LoginPasswordFieldCardPreviewWrapper(
            title: "CONTRASEÑA",
            placeholder: "••••••••",
            initialText: "Clave123@",
            isVisible: true
        )
        
        // Estado vacío
        LoginPasswordFieldCardPreviewWrapper(
            title: "CONTRASEÑA",
            placeholder: "••••••••",
            initialText: "",
            isVisible: false
        )
        
    }
    .padding(20)
    .background(SRIColors.background)
}

/// Wrapper para manejar @Binding en previews
private struct LoginPasswordFieldCardPreviewWrapper: View {
    
    let title: String
    let placeholder: String
    
    @State private var text: String
    @State private var isVisible: Bool
    
    init(title: String, placeholder: String, initialText: String, isVisible: Bool) {
        self.title = title
        self.placeholder = placeholder
        _text = State(initialValue: initialText)
        _isVisible = State(initialValue: isVisible)
    }
    
    var body: some View {
        LoginPasswordFieldCard(
            title: title,
            placeholder: placeholder,
            text: $text,
            isPasswordVisible: $isVisible,
            isFocused: false,
            onTap: {},
            onSubmit: {}
        )
    }
}
