//
//  LoginPrimaryButton.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import SwiftUI

/// Botón primario reutilizable para acciones principales de la pantalla de login.
struct LoginPrimaryButton: View {
    
    let title: String
    let isLoading: Bool
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                }
                
                Text(title)
                    .font(.headline)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(
                        isEnabled
                        ? SRIColors.primary
                        : SRIColors.primary.opacity(0.35)
                    )
            )
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled || isLoading)
        .opacity(isEnabled ? 1 : 0.95)
    }
}

#Preview("Estados botón") {
    VStack(spacing: 16) {
        
        LoginPrimaryButton(
            title: "Ingresar",
            isLoading: false,
            isEnabled: true,
            action: {}
        )
        
        LoginPrimaryButton(
            title: "Ingresando…",
            isLoading: true,
            isEnabled: true,
            action: {}
        )
        
        LoginPrimaryButton(
            title: "Ingresar",
            isLoading: false,
            isEnabled: false,
            action: {}
        )
        
    }
    .padding(20)
    .background(SRIColors.background)
}
