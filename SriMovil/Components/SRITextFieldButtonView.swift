//
//  SRITextFieldButtonView.swift
//  SriMovil
//
//  Created by usradmin on 27/3/26.
//

import SwiftUI

import SwiftUI

enum SRITextInputMode {
    case numeric(maxLength: Int)
    case alphanumeric(maxLength: Int?, uppercase: Bool)
    case freeText(maxLength: Int?)
}

struct SRITextFieldButtonView: View {
    @Binding var texto: String
    let placeholder: String
    let icono: String
    let inputMode: SRITextInputMode
    var hasValidationError: Bool = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icono)
                .foregroundStyle(SRIColors.textSecondary)
            
            TextField(
                "",
                text: $texto,
                prompt: Text(placeholder)
                    .foregroundStyle(SRIColors.textSecondary)
                    .italic()
            )
            .textFieldStyle(.plain)
            .font(.body)
            .foregroundStyle(SRIColors.textPrimary)
            .tint(SRIColors.primary)
            .keyboardType(keyboardType)
            .textInputAutocapitalization(textAutocapitalization)
            .autocorrectionDisabled()
            .focused($isFocused)
            .onChange(of: texto) { _, newValue in
                texto = sanitize(newValue)
            }
            
            if !texto.isEmpty {
                Button {
                    texto = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(SRIColors.textSecondary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Limpiar campo")
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 52)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(
                    hasValidationError ? SRIColors.error.opacity(0.65) : SRIColors.border,
                    lineWidth: 1
                )
        }
        .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
    
    private var keyboardType: UIKeyboardType {
        switch inputMode {
        case .numeric:
            return .numberPad
        case .alphanumeric, .freeText:
            return .default
        }
    }
    
    private var textAutocapitalization: TextInputAutocapitalization {
        switch inputMode {
        case .numeric:
            return .never
        case .alphanumeric(_, let uppercase):
            return uppercase ? .characters : .never
        case .freeText:
            return .sentences
        }
    }
    
    private func sanitize(_ value: String) -> String {
        switch inputMode {
        case .numeric(let maxLength):
            let filtered = value.filter(\.isNumber)
            return String(filtered.prefix(maxLength))
            
        case .alphanumeric(let maxLength, let uppercase):
            let filtered = value.filter { $0.isLetter || $0.isNumber }
            let transformed = uppercase ? filtered.uppercased() : String(filtered)
            
            if let maxLength {
                return String(transformed.prefix(maxLength))
            } else {
                return transformed
            }
            
        case .freeText(let maxLength):
            if let maxLength {
                return String(value.prefix(maxLength))
            } else {
                return value
            }
        }
    }
}

#Preview("Estados SRITextFieldButtonView") {
    VStack(spacing: 20) {
        
        // MARK: - RUC (vacío)
        SRITextFieldButtonView(
            texto: .constant(""),
            placeholder: "Ej: 1700000000001",
            icono: "creditcard.fill",
            inputMode: .numeric(maxLength: 13),
            hasValidationError: false
        )
        
        // MARK: - RUC (válido)
        SRITextFieldButtonView(
            texto: .constant("1712245974001"),
            placeholder: "Ej: 1700000000001",
            icono: "creditcard.fill",
            inputMode: .numeric(maxLength: 13),
            hasValidationError: false
        )
        
        // MARK: - RUC (error)
        SRITextFieldButtonView(
            texto: .constant("17122459740"),
            placeholder: "Ej: 1700000000001",
            icono: "creditcard.fill",
            inputMode: .numeric(maxLength: 13),
            hasValidationError: true
        )
        
        Divider()
        
        // MARK: - Placa (vacío)
        SRITextFieldButtonView(
            texto: .constant(""),
            placeholder: "Ej: AAA0123",
            icono: "car.fill",
            inputMode: .alphanumeric(maxLength: 20, uppercase: true),
            hasValidationError: false
        )
        
        // MARK: - Placa (válida)
        SRITextFieldButtonView(
            texto: .constant("PFE8576"),
            placeholder: "Ej: AAA0123",
            icono: "car.fill",
            inputMode: .alphanumeric(maxLength: 20, uppercase: true),
            hasValidationError: false
        )
        
        // MARK: - RAMV / texto largo
        SRITextFieldButtonView(
            texto: .constant("U02506654-LARGO-DE-EJEMPLO"),
            placeholder: "Ej: AAA0123",
            icono: "car.fill",
            inputMode: .alphanumeric(maxLength: 30, uppercase: true),
            hasValidationError: false
        )
        
        // MARK: - Error placa
        SRITextFieldButtonView(
            texto: .constant("ABC"),
            placeholder: "Ej: AAA0123",
            icono: "car.fill",
            inputMode: .alphanumeric(maxLength: 20, uppercase: true),
            hasValidationError: true
        )
    }
    .padding()
    .background(SRIColors.background)
}

#Preview("Dark Mode") {
    VStack(spacing: 20) {
        SRITextFieldButtonView(
            texto: .constant("1712245974001"),
            placeholder: "Ej: 1700000000001",
            icono: "creditcard.fill",
            inputMode: .numeric(maxLength: 13),
            hasValidationError: false
        )
        
        SRITextFieldButtonView(
            texto: .constant("PFE8576"),
            placeholder: "Ej: AAA0123",
            icono: "car.fill",
            inputMode: .alphanumeric(maxLength: 20, uppercase: true),
            hasValidationError: false
        )
    }
    .padding()
    .background(SRIColors.background)
    .preferredColorScheme(.dark)
}
