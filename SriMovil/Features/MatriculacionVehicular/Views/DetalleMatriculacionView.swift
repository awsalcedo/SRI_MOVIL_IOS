//
//  DetalleMatriculacionView.swift
//  SriMovil
//
//  Created by usradmin on 6/8/24.
//

import SwiftUI

struct DetalleMatriculacionView: View {
    let infoVehiculo: InfoVehiculoModel
    
    var body: some View {
        List {
            Section {
                if let deudas = infoVehiculo.deudas, !deudas.isEmpty {
                    valoresPagarRow
                } else {
                    noValuesRow
                }
            }
            
            Section("Información del vehículo") {
                MatriculacionDetailRow(iconName: "car.fill", label: "Placa", value: infoVehiculo.placa)
                MatriculacionDetailRow(iconName: "number", label: "RAMV o CPN", value: infoVehiculo.camvCpn)
                MatriculacionDetailRow(iconName: "tag.fill", label: "Marca", value: infoVehiculo.marca)
                MatriculacionDetailRow(iconName: "doc.text.fill", label: "Modelo", value: infoVehiculo.modelo)
                MatriculacionDetailRow(iconName: "calendar", label: "Año modelo", value: String(infoVehiculo.anioModelo))
                MatriculacionDetailRow(iconName: "flag.fill", label: "País de fabricación", value: infoVehiculo.paisFabricacion)
                MatriculacionDetailRow(iconName: "clock.fill", label: "Último pago", value: String(infoVehiculo.anioUltimoPago))
                MatriculacionDetailRow(iconName: "shippingbox.fill", label: "Clase", value: infoVehiculo.clase)
                MatriculacionDetailRow(iconName: "person.2.fill", label: "Servicio", value: infoVehiculo.servicio)
                MatriculacionDetailRow(iconName: "car.rear.fill", label: "Tipo de uso", value: infoVehiculo.tipoUso)
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(SRIBackgrounds.formGradient)
        .navigationTitle("Detalle del vehículo")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var valoresPagarRow: some View {
        NavigationLink {
            TipoDeudasView(deudas: infoVehiculo.deudas ?? [])
        } label: {
            LabeledContent("Valor total a pagar") {
                Text(FormatterUtils.formattedCurrency(value: infoVehiculo.total ?? 0.00))
                    .fontWeight(.semibold)
                    .foregroundStyle(SRIColors.primary)
            }
        }
    }
    
    private var noValuesRow: some View {
        HStack(spacing: 12) {
            Text("Estado")
                .foregroundStyle(SRIColors.textPrimary)
            
            Spacer()
            
            Label("Sin valores pendientes", systemImage: "checkmark.seal.fill")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.green)
        }
    }
}

struct MatriculacionDetailRow: View {
    let iconName: String
    let label: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName)
                .font(.title3)
                .foregroundStyle(SRIColors.secondaryIconBlue.opacity(0.78))
                .frame(width: 28, alignment: .center)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.subheadline)
                    .foregroundStyle(SRIColors.textSecondary)
                
                Text(value)
                    .font(.body)
                    .foregroundStyle(SRIColors.textPrimary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview("Con deudas") {
    NavigationStack {
        DetalleMatriculacionView(
            infoVehiculo: MatriculacionPreviewData.vehiculoConDeudas
        )
    }
}

#Preview("Sin deudas") {
    NavigationStack {
        DetalleMatriculacionView(
            infoVehiculo: MatriculacionPreviewData.vehiculoSinDeudas
        )
    }
}

#Preview("Dark Mode - Con deudas") {
    NavigationStack {
        DetalleMatriculacionView(
            infoVehiculo: MatriculacionPreviewData.vehiculoConDeudas
        )
    }
    .preferredColorScheme(.dark)
}

#Preview("Dark Mode - Sin deudas") {
    NavigationStack {
        DetalleMatriculacionView(
            infoVehiculo: MatriculacionPreviewData.vehiculoSinDeudas
        )
    }
    .preferredColorScheme(.dark)
}

#Preview("Textos largos") {
    NavigationStack {
        DetalleMatriculacionView(
            infoVehiculo: MatriculacionPreviewData.vehiculoConTextosLargos
        )
    }
}

#Preview("Dark Mode - Textos largos") {
    NavigationStack {
        DetalleMatriculacionView(
            infoVehiculo: MatriculacionPreviewData.vehiculoConTextosLargos
        )
    }
    .preferredColorScheme(.dark)
}
