//
//  ServicioRowCard.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
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
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.leading)
                
                Text(subtitulo(for: servicio.categoria))
                    .font(.footnote)
                    .foregroundStyle(AppColors.textSecondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(16)
        .background(AppColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.medium, style: .continuous))
    }
    
    private var iconContainer: some View {
        Group {
            if let nombreImagen = servicio.imagenServicio {
                Image(nombreImagen)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
            } else {
                Image(systemName: "square.grid.2x2")
                    .font(.title3)
                    .foregroundStyle(AppColors.primary)
            }
        }
        .frame(width: 52, height: 52)
        .background(AppColors.surfaceSecondary)
        .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.small, style: .continuous))
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
    .background(AppColors.background)
}
