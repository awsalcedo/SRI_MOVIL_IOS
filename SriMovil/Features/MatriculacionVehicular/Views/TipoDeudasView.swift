//
//  TipoDeudasView.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import SwiftUI

struct TipoDeudasView: View {
    let deudas: [Deuda]
    
    var body: some View {
        Group {
            if deudas.isEmpty {
                ContentUnavailableView(
                    "No existen deudas",
                    systemImage: "checkmark.seal",
                    description: Text("El vehículo no registra deudas por tipo en este momento.")
                )
            } else {
                List {
                    Section("Por tipo de deuda") {
                        ForEach(deudas) { deuda in
                            NavigationLink {
                                RubrosView(rubros: deuda.rubros)
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(deuda.descripcion)
                                        .font(.headline)
                                        .foregroundStyle(SRIColors.textPrimary)
                                        .multilineTextAlignment(.leading)
                                    
                                    LabeledContent("Subtotal") {
                                        Text(FormatterUtils.formattedCurrency(value: deuda.subtotal))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(SRIColors.primary)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Deudas")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("Una deuda") {
    NavigationStack {
        TipoDeudasView(deudas: [
            MatriculacionPreviewData.deudaSimple
        ])
    }
}

#Preview("Varias deudas") {
    NavigationStack {
        TipoDeudasView(deudas: MatriculacionPreviewData.deudasVarias)
    }
}

#Preview("Sin deudas") {
    NavigationStack {
        TipoDeudasView(deudas: MatriculacionPreviewData.deudasVacias)
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        TipoDeudasView(deudas: MatriculacionPreviewData.deudasVarias)
    }
    .preferredColorScheme(.dark)
}


