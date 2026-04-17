//
//  RubrosView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct RubrosView: View {
    let rubros: [Rubro]
    @State private var rubroSeleccionado: Rubro?
    
    var body: some View {
        Group {
            if rubros.isEmpty {
                ContentUnavailableView(
                    "Sin rubros",
                    systemImage: "doc.text.magnifyingglass",
                    description: Text("No existen rubros disponibles para este concepto.")
                )
            } else {
                List {
                    Section {
                        ForEach(rubros) { rubro in
                            Button {
                                rubroSeleccionado = rubro
                            } label: {
                                RubroRowView(rubro: rubro)
                            }
                            .buttonStyle(.plain)
                            .listRowInsets(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16))
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Rubros")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $rubroSeleccionado) { rubroSeleccionado in
            DetalleRubrosView(
                detalleRubros: rubroSeleccionado.detallesRubro,
                descripcionRubro: rubroSeleccionado.descripcion
            ) {
                self.rubroSeleccionado = nil
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }
}

private struct RubroRowView: View {
    let rubro: Rubro
    
    var body: some View {
        HStack(spacing: 12) {
            
            // IZQUIERDA (contenido)
            VStack(alignment: .leading, spacing: 6) {
                Text(rubro.descripcion)
                    .font(.headline)
                    .foregroundStyle(SRIColors.textPrimary)
                
                Text(rubro.periodoFiscal)
                    .font(.subheadline)
                    .foregroundStyle(SRIColors.textSecondary)
                
                Text(rubro.beneficiario)
                    .font(.subheadline)
                    .foregroundStyle(SRIColors.textSecondary)
            }
            
            Spacer(minLength: 12)
            
            // DERECHA (valor + chevron centrados)
            HStack(spacing: 12) {
                Text(FormatterUtils.formattedCurrency(value: rubro.valor))
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(SRIColors.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)
                
                Image(systemName: "chevron.right")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(SRIColors.textSecondary)
            }
            .frame(alignment: .center)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}

#Preview("Un rubro") {
    NavigationStack {
        RubrosView(
            rubros: [
                MatriculacionPreviewData.rubroImpuesto
            ]
        )
    }
}

#Preview("Varios rubros") {
    NavigationStack {
        RubrosView(
            rubros: [
                MatriculacionPreviewData.rubroImpuesto,
                MatriculacionPreviewData.rubroTasa,
                MatriculacionPreviewData.rubroTransferencia
            ]
        )
    }
}

#Preview("Sin rubros") {
    NavigationStack {
        RubrosView(
            rubros: []
        )
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        RubrosView(
            rubros: [
                MatriculacionPreviewData.rubroImpuesto,
                MatriculacionPreviewData.rubroTasa,
                MatriculacionPreviewData.rubroTransferencia
            ]
        )
    }
    .preferredColorScheme(.dark)
}




