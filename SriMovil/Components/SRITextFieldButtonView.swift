//
//  SRITextFieldButtonView.swift
//  SriMovil
//
//  Created by usradmin on 27/3/26.
//

import SwiftUI

struct SRITextFieldButtonView: View {
    @Binding var texto: String
    let placeholder: String
    let icono: String
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
            .keyboardType(.numberPad)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .focused($isFocused)
            .onChange(of: texto) { _, newValue in
                let filtered = newValue.filter(\.isNumber)
                texto = String(filtered.prefix(13))
            }
            
            if !texto.isEmpty {
                Button {
                    texto = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(SRIColors.textSecondary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Limpiar RUC")
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
}

#Preview("Estados SRITextFieldButtonView") {
    VStack(spacing: 20) {
        SRITextFieldButtonView(
            texto: .constant(""),
            placeholder: "Ej: 1700000000001",
            icono: "creditcard.fill",
            hasValidationError: false
        )
        
        SRITextFieldButtonView(
            texto: .constant("1712245974001"),
            placeholder: "Ej: 1700000000001",
            icono: "creditcard.fill",
            hasValidationError: false
        )
        
        SRITextFieldButtonView(
            texto: .constant("17122459740"),
            placeholder: "Ej: 1700000000001",
            icono: "creditcard.fill",
            hasValidationError: true
        )
    }
    .padding()
    .background(SRIColors.background)
}
