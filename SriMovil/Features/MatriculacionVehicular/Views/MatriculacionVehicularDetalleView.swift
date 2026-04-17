//
//  MatriculacionVehicularDetalleView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct MatriculacionVehicularDetalleView: View {
    let infoVehiculo: InfoVehiculoModel
    
    private var hasValoresPendientes: Bool {
        !(infoVehiculo.deudas?.isEmpty ?? true)
    }
    
    private var hasDeudas: Bool {
        !(infoVehiculo.deudas?.isEmpty ?? true)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            vehicleSummaryCard
            
            NavigationLink {
                DetalleMatriculacionView(infoVehiculo: infoVehiculo)
            } label: {
                Label("Ver detalle del vehículo", systemImage: "list.bullet.rectangle")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(SRIColors.primary)
            
            
            if hasValoresPendientes {
                NavigationLink {
                    TipoDeudasView(deudas: infoVehiculo.deudas ?? [])
                } label: {
                    totalToPayCard
                }
                .buttonStyle(.plain)
            } else {
                noPendingValuesCard
            }
        }
    }
    
    private var vehicleSummaryCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(infoVehiculo.placa)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(SRIColors.textPrimary)
                    
                    Text("\(infoVehiculo.marca) · \(infoVehiculo.modelo)")
                        .font(.subheadline)
                        .foregroundStyle(SRIColors.textSecondary)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                VehicleYearBadge(year: infoVehiculo.anioModelo)
            }
  
            Divider()

            VehicleSummaryRow(label: "RAMV o CPN", value: infoVehiculo.camvCpn)
            VehicleSummaryRow(label: "Servicio", value: infoVehiculo.servicio)
            VehicleSummaryRow(label: "Clase", value: infoVehiculo.clase)
            VehicleSummaryRow(label: "Último pago", value: String(infoVehiculo.anioUltimoPago))
        }
        .padding(20)
        .sriContentSurface()
    }
    
    struct VehicleSummaryRow: View {
        let label: String
        let value: String
        
        var body: some View {
            HStack(alignment: .top, spacing: 16) {
                Text(label)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(SRIColors.textPrimary)
                    .frame(width: 110, alignment: .leading)
                
                Text(value)
                    .font(.subheadline)
                    .foregroundStyle(SRIColors.textSecondary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    
    private var totalToPayCard: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Valor total a pagar")
                    .font(.subheadline)
                    .foregroundStyle(SRIColors.textSecondary)
                
                Text(FormatterUtils.formattedCurrency(value: infoVehiculo.total ?? 0.00))
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(SRIColors.textPrimary)
                
                Text("Ver rubros y deudas por tipo")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(SRIColors.primary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.headline.weight(.semibold))
                .foregroundStyle(SRIColors.textSecondary)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(SRIColors.border.opacity(0.35), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.03), radius: 6, y: 2)
        .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .padding(.top, 8)
    }
    
    private var noPendingValuesCard: some View {
        ContentUnavailableView(
            "No existen valores a pagar",
            systemImage: "checkmark.seal",
            description: Text("El vehículo no presenta valores pendientes en este momento.")
        )
        .frame(maxWidth: .infinity)
        .padding(20)
        .sriContentSurface()
    }
}

struct VehicleYearBadge: View {
    let year: Int
    
    var body: some View {
        Text(String(year))
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(SRIColors.primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule(style: .continuous)
                    .fill(SRIColors.primary.opacity(0.12))
            )
    }
}

#Preview("Con deudas") {
    NavigationStack {
        MatriculacionVehicularDetalleView(
            infoVehiculo: MatriculacionPreviewData.vehiculoConDeudas
        )
        .padding()
        .background(SRIColors.background)
    }
}

#Preview("Sin deudas") {
    NavigationStack {
        MatriculacionVehicularDetalleView(
            infoVehiculo: MatriculacionPreviewData.vehiculoSinDeudas
        )
        .padding()
        .background(SRIColors.background)
    }
}

#Preview("Textos largos") {
    NavigationStack {
        MatriculacionVehicularDetalleView(
            infoVehiculo: MatriculacionPreviewData.vehiculoConTextosLargos
        )
        .padding()
        .background(SRIColors.background)
    }
}

#Preview("Dark Mode - Con deudas") {
    NavigationStack {
        MatriculacionVehicularDetalleView(
            infoVehiculo: MatriculacionPreviewData.vehiculoConDeudas
        )
        .padding()
        .background(SRIColors.background)
    }
    .preferredColorScheme(.dark)
}

#Preview("Dark Mode - Sin deudas") {
    NavigationStack {
        MatriculacionVehicularDetalleView(
            infoVehiculo: MatriculacionPreviewData.vehiculoSinDeudas
        )
        .padding()
        .background(SRIColors.background)
    }
    .preferredColorScheme(.dark)
}

#Preview("Dark Mode - Textos largos") {
    NavigationStack {
        MatriculacionVehicularDetalleView(
            infoVehiculo: MatriculacionPreviewData.vehiculoConTextosLargos
        )
        .padding()
        .background(SRIColors.background)
    }
    .preferredColorScheme(.dark)
}
