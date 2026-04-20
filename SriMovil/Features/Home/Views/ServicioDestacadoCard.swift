//
//  ServicioDestacadoCard.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import SwiftUI

struct ServicioDestacadoCard: View {
    
    let servicio: Servicio
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                iconView
                
                Spacer(minLength: 0)
                
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            
            Spacer(minLength: 0)
            
            Text(servicio.nombreServicio)
                .font(.headline)
                .foregroundStyle(AppColors.textPrimary)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
        }
        .padding(18)
        .frame(width: 200, height: 148, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: AppCornerRadius.large, style: .continuous)
                .fill(.regularMaterial)
        )
        .overlay {
            RoundedRectangle(cornerRadius: AppCornerRadius.large, style: .continuous)
                .stroke(Color.white.opacity(0.28), lineWidth: 0.8)
        }
        .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 6)
    }
    
    @ViewBuilder
    private var iconView: some View {
        if let nombreImagen = servicio.imagenServicio {
            Image(nombreImagen)
                .resizable()
                .scaledToFit()
                .frame(width: 54, height: 54)
        } else {
            Image(systemName: "square.grid.2x2.fill")
                .font(.title2)
                .foregroundStyle(AppColors.primary)
        }
    }
}

#Preview {
    ServicioDestacadoCard(
        servicio: Servicio(
            nombreServicio: "Estado Tributario",
            imagenServicio: nil,
            categoria: .tributario,
            destino: .estadoTributario,
            esDestacado: true
        )
    )
    .padding()
    .background(AppColors.background)
}
