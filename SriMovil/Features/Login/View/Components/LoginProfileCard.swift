//
//  LoginProfileCard.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import SwiftUI

/// Tarjeta reutilizable para mostrar la identidad conocida del contribuyente.
struct LoginProfileCard: View {
    
    let title: String
    let identificacion: String
    let razonSocial: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundStyle(SRIColors.textPrimary)
            
            VStack(alignment: .leading, spacing: 10) {
                profileRow(
                    label: "Identificación",
                    value: identificacion
                )
                
                profileRow(
                    label: "Razón social",
                    value: razonSocial
                )
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.thinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(SRIColors.border.opacity(0.24), lineWidth: 1)
        )
    }
    
    @ViewBuilder
    private func profileRow(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label.uppercased())
                .font(.caption.weight(.semibold))
                .foregroundStyle(SRIColors.textSecondary)
            
            Text(value)
                .font(.body)
                .foregroundStyle(SRIColors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview("Perfil") {
    ScrollView {
        VStack {
            LoginProfileCard(
                title: "Perfil",
                identificacion: "1712245974",
                razonSocial: "TASINCHANO ENRÍQUEZ EDWIN JAVIER"
            )
        }
        .padding(20)
    }
    .background(SRIColors.background)
}
