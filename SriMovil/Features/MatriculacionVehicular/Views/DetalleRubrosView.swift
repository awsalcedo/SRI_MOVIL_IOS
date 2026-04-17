//
//  DetalleRubrosView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct DetalleRubrosView: View {
    let detalleRubros: [DetallesRubro]
    let descripcionRubro: String
    let cerrarSheet: () -> Void
    
    var body: some View {
        NavigationStack {
            Group {
                if detalleRubros.isEmpty {
                    ContentUnavailableView(
                        "No hay detalles disponibles",
                        systemImage: "tray",
                        description: Text("Este rubro no tiene un desglose adicional.")
                    )
                } else {
                    List {
                        Section {
                            ForEach(detalleRubros) { detalle in
                                DetalleRubroRowView(detalle: detalle)
                                    .listRowInsets(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16))
                            }
                        } header: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Concepto")
                                    .font(.caption)
                                    .foregroundStyle(SRIColors.textSecondary)
                                
                                Text(descripcionRubro)
                                    .font(.subheadline.weight(.medium))
                                    .foregroundStyle(SRIColors.textPrimary)
                            }
                            .textCase(nil)
                            .padding(.bottom, 4)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Detalle de rubros")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        cerrarSheet()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .accessibilityLabel("Cerrar")
                }
            }
        }
    }
}

private struct DetalleRubroRowView: View {
    let detalle: DetallesRubro
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(detalle.descripcion)
                    .font(.headline)
                    .foregroundStyle(SRIColors.textPrimary)
                
                Text(String(detalle.anio))
                    .font(.subheadline)
                    .foregroundStyle(SRIColors.textSecondary)
            }
            
            Spacer(minLength: 12)
            
            Text(FormatterUtils.formattedCurrency(value: detalle.valor))
                .font(.headline.weight(.semibold))
                .foregroundStyle(SRIColors.textPrimary)
                .multilineTextAlignment(.trailing)
        }
        .contentShape(Rectangle())
    }
}

#Preview("Con detalles") {
    DetalleRubrosView(
        detalleRubros: MatriculacionPreviewData.detallesRubroImpuesto,
        descripcionRubro: MatriculacionPreviewData.rubroImpuesto.descripcion,
        cerrarSheet: {}
    )
}

#Preview("Sin detalles") {
    DetalleRubrosView(
        detalleRubros: [],
        descripcionRubro: "Rubro sin desglose",
        cerrarSheet: {}
    )
}

#Preview("Transferencia") {
    DetalleRubrosView(
        detalleRubros: MatriculacionPreviewData.detallesRubroTransferencia,
        descripcionRubro: MatriculacionPreviewData.rubroTransferencia.descripcion,
        cerrarSheet: {}
    )
}

#Preview("Dark Mode") {
    DetalleRubrosView(
        detalleRubros: MatriculacionPreviewData.detallesRubroImpuesto,
        descripcionRubro: MatriculacionPreviewData.rubroImpuesto.descripcion,
        cerrarSheet: {}
    )
    .preferredColorScheme(.dark)
}
