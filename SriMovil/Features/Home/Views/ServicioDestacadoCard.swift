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
        VStack(alignment: .leading, spacing: 12) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(SRIColors.primary.opacity(0.12))
                
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundStyle(SRIColors.primary)
            }
            .frame(width: 44, height: 44)
            
            Text(servicio.nombreServicio)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .lineLimit(2)
            
            Spacer()
        }
        .padding(16)
        .frame(width: 150, height: 120)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.background)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black.opacity(0.04))
        }
    }
    
    private var iconName: String {
        switch servicio.destino {
        case .valoresPagar: return "car.fill"
        case .estadoTributario: return "doc.text.fill"
        case .deudas: return "exclamationmark.triangle.fill"
        default: return "square.grid.2x2.fill"
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
    .background(SRIColors.background)
}
