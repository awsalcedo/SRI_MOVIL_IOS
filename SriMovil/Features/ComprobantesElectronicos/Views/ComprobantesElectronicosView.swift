//
//  ComprobantesElectronicosView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 24/4/26.
//

import SwiftUI

struct ComprobantesElectronicosView: View {
    
    let razonSocial: String
    let onOpenAccount: () -> Void
    
    init(
        razonSocial: String,
        onOpenAccount: @escaping () -> Void = {}
    ) {
        self.razonSocial = razonSocial
        self.onOpenAccount = onOpenAccount
    }
    
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
                    onOpenAccount()
                } label: {
                    Image(systemName: "person.crop.circle")
                }
                .accessibilityLabel("Cuenta")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ComprobantesElectronicosView(razonSocial: "TASINCHANO ENRÍQUEZ EDWIN JAVIER")
    }
}
