//
//  LoginFieldCard.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import SwiftUI

/// Campo de entrada reutilizable para la pantalla de login.
///
/// Este componente encapsula un `TextField` con estilo visual consistente
/// con el resto del formulario.
struct LoginFieldCard: View {
    
    enum InputMode {
        case normal
        case uppercase
        case digits
    }
    
    let title: String
    let placeholder: String
    @Binding var text: String
    let keyboardType: UIKeyboardType
    let textContentType: UITextContentType?
    let submitLabel: SubmitLabel
    let inputMode: InputMode
    let isFocused: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(SRIColors.textSecondary.opacity(0.72))
                .tracking(0.8)
            
            TextField(
                "",
                text: binding,
                prompt: Text(placeholder)
                    .font(.callout)
                    .foregroundStyle(SRIColors.textSecondary.opacity(0.92))
            )
            .keyboardType(keyboardType)
            .textInputAutocapitalization(.never)
            .textContentType(textContentType)
            .autocorrectionDisabled()
            .submitLabel(submitLabel)
            .font(.callout.weight(.medium))
            .foregroundStyle(SRIColors.textPrimary)
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
    
    private var binding: Binding<String> {
        Binding(
            get: { text },
            set: { newValue in
                switch inputMode {
                case .normal:
                    text = newValue
                case .uppercase:
                    text = newValue.uppercased()
                case .digits:
                    text = newValue.filter(\.isNumber)
                }
            }
        )
    }
}

#Preview("Field States") {
    VStack(spacing: 20) {
        
        LoginFieldCardPreviewWrapper(
            title: "IDENTIFICACIÓN",
            placeholder: "RUC / C.I. / Pasaporte",
            initialText: "1712245974",
            keyboardType: .asciiCapable,
            textContentType: .username,
            submitLabel: .next,
            inputMode: .uppercase
        )
        
        LoginFieldCardPreviewWrapper(
            title: "C.I. ADICIONAL",
            placeholder: "Opcional",
            initialText: "001",
            keyboardType: .numberPad,
            textContentType: .none,
            submitLabel: .next,
            inputMode: .digits
        )
        
        LoginFieldCardPreviewWrapper(
            title: "IDENTIFICACIÓN",
            placeholder: "RUC / C.I. / Pasaporte",
            initialText: "",
            keyboardType: .asciiCapable,
            textContentType: .username,
            submitLabel: .done,
            inputMode: .uppercase
        )
        
    }
    .padding(20)
    .background(SRIColors.background)
}

/// Wrapper para manejar @Binding en previews
private struct LoginFieldCardPreviewWrapper: View {
    
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let textContentType: UITextContentType?
    let submitLabel: SubmitLabel
    let inputMode: LoginFieldCard.InputMode
    
    @State private var text: String
    
    init(
        title: String,
        placeholder: String,
        initialText: String,
        keyboardType: UIKeyboardType,
        textContentType: UITextContentType?,
        submitLabel: SubmitLabel,
        inputMode: LoginFieldCard.InputMode
    ) {
        self.title = title
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.submitLabel = submitLabel
        self.inputMode = inputMode
        _text = State(initialValue: initialText)
    }
    
    var body: some View {
        LoginFieldCard(
            title: title,
            placeholder: placeholder,
            text: $text,
            keyboardType: keyboardType,
            textContentType: textContentType,
            submitLabel: submitLabel,
            inputMode: inputMode,
            isFocused: false,
            onTap: {}
        )
    }
}
