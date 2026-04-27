//
//  VerMasServiciosRow.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 27/4/26.
//
import SwiftUI

struct VerMasServiciosRow: View {
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "ellipsis.circle")
                .font(.title3.weight(.semibold))
                .foregroundStyle(SRIColors.primary)
                .frame(width: 44, height: 44)
            
            Text("Ver todos los servicios")
                .font(.body.weight(.medium))
                .foregroundStyle(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .contentShape(Rectangle())
    }
}

#Preview {
    VerMasServiciosRow()
}
