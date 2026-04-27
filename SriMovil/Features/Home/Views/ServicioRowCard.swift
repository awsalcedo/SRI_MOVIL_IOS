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
        Group {
            if let nombreImagen = servicio.imagenServicio {
                Image(nombreImagen)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
            } else {
                Image(systemName: "square.grid.2x2")
                    .font(.title3)
                    .foregroundStyle(SRIColors.primary)
            }
        }
        .frame(width: 52, height: 52)
        .background(SRIColors.surfaceSecondary)
        .clipShape(RoundedRectangle(cornerRadius: SRICornerRadius.small, style: .continuous))
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
