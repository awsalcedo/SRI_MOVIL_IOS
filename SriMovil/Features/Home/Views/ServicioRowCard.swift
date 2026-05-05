//
//  ServicioRowCard.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 17/4/26.
//

import SwiftUI

struct ServicioRowCard: View {
    
    let servicio: Servicio
    
    var body: some View {
        HStack(spacing: 14) {
            iconContainer
            
            VStack(alignment: .leading, spacing: 4) {
                Text(servicio.nombreServicio)
                    .font(.body.weight(.semibold))
                    .foregroundStyle(SRIColors.textPrimary)
                    .multilineTextAlignment(.leading)
                
                Text(subtitulo(for: servicio.categoria))
                    .font(.footnote)
                    .foregroundStyle(SRIColors.textSecondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(16)
        .background(SRIColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: SRICornerRadius.medium, style: .continuous))
    }
    
    private var iconContainer: some View {
        ZStack {
            RoundedRectangle(cornerRadius: SRICornerRadius.small, style: .continuous)
                .fill(SRIColors.surfaceSecondary)
                .frame(width: 52, height: 52)
            
            iconImage
        }
    }
    
    @ViewBuilder
    private var iconImage: some View {
        if let assetName = servicio.imagenServicio ?? servicio.destino.assetIconName {
            Image(assetName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 26)
                .foregroundStyle(SRIColors.primary)
                .accessibilityHidden(true)
        } else {
            Image(systemName: "square.grid.2x2")
                .font(.title3.weight(.semibold))
                .foregroundStyle(SRIColors.primary)
                .accessibilityHidden(true)
        }
    }
    
    private func subtitulo(for categoria: CategoriaServicio) -> String {
        switch categoria {
        case .vehiculos:
            return "Consultas vehiculares"
        case .tributario:
            return "Información tributaria"
        case .documentos:
            return "Documentos y certificados"
        case .tramites:
            return "Trámites y validaciones"
        case .herramientas:
            return "Utilidades"
        case .soporte:
            return "Ayuda y contacto"
        }
    }
}

#Preview {
    ServicioRowCard(
        servicio: Servicio(
            nombreServicio: "Matriculación Vehicular",
            imagenServicio: nil,
            categoria: .vehiculos,
            destino: .valoresPagar
        )
    )
    .padding()
    .background(SRIColors.background)
}
