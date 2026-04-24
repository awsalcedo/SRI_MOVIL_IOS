//
//  ComprobantesElectronicosView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 24/4/26.
//

import SwiftUI

struct ComprobantesElectronicosView: View {
    
    let razonSocial: String
    
    @Environment(\.dismiss) private var dismiss
    @State private var showLogin = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Comprobantes Electrónicos")
                    .font(.title.weight(.semibold))
                    .foregroundStyle(SRIColors.textPrimary)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Contribuyente")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(SRIColors.textSecondary)
                    
                    Text(razonSocial)
                        .font(.body.weight(.medium))
                        .foregroundStyle(SRIColors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                )
            }
            .padding(20)
        }
        .background(SRIColors.background.ignoresSafeArea())
        .navigationTitle("Comprobantes")
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showLogin = true
                } label: {
                    Image(systemName: "person.crop.circle")
                }
                .accessibilityLabel("Cuenta")
            }
        }
        .sheet(isPresented: $showLogin) {
            LoginView(
                onSessionEnded: {
                    showLogin = false
                    dismiss()
                }
            )
        }
    }
}

#Preview {
    NavigationStack {
        ComprobantesElectronicosView(razonSocial: "TASINCHANO ENRÍQUEZ EDWIN JAVIER")
    }
}
