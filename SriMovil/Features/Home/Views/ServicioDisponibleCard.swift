//
//  ServicioDisponibleCard.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/5/26.
//

import SwiftUI

/// Tarjeta visual para representar un servicio dentro del catálogo de consultas disponibles.
///
/// `ServicioDisponibleCard` está diseñada para secciones tipo grid, donde varios
/// servicios se presentan con una jerarquía visual uniforme y sobria.
///
/// A diferencia de `ServicioDestacadoCard`, este componente evita colores muy
/// saturados por servicio para mantener una lectura más calmada en listados amplios.
struct ServicioDisponibleCard: View {
    
    // MARK: - Properties
    
    let servicio: Servicio
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 14) {
            icon
            
            Text(servicio.nombreServicio)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(SRIColors.textPrimary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.88)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 16)
        .frame(width: 154, height: 124)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(SRIColors.cardBackground)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(SRIColors.border.opacity(0.22), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.04), radius: 10, x: 0, y: 5)
        .contentShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
    
    // MARK: - Subviews
    
    private var icon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(iconBackground)
                .frame(width: 52, height: 52)
            
            iconImage
                .frame(width: 24, height: 24)
        }
        .shadow(color: SRIColors.cardIconBlue.opacity(0.16), radius: 8, x: 0, y: 4)
    }
    
    @ViewBuilder
    private var iconImage: some View {
        if let assetName = servicio.destino.assetIconName {
            Image(assetName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .accessibilityHidden(true)
        } else {
            Image(systemName: "square.grid.2x2.fill")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
                .accessibilityHidden(true)
        }
    }
    
    private var iconBackground: LinearGradient {
        LinearGradient(
            colors: [
                SRIColors.cardIconBlue,
                SRIColors.cardIconBlue.opacity(0.78)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    ServicioDisponibleCard(
        servicio: Servicio(
            nombreServicio: "Validación QR",
            imagenServicio: nil,
            categoria: .tramites,
            destino: .validacionQR
        )
    )
    .padding()
    .background(SRIColors.background)
}
