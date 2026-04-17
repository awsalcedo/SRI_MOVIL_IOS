//
//  MatriculacionEmptyStateView.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import SwiftUI

struct MatriculacionEmptyStateView: View {
    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "car.circle")
                .font(.system(size: 38, weight: .regular))
                .foregroundStyle(SRIColors.textSecondary)
            
            Text("Aún no hay resultados")
                .font(.headline)
                .foregroundStyle(SRIColors.textPrimary)
            
            Text("Cuando ingreses una placa, RAMV o CPN y presiones “Consultar valores”, aquí verás el resumen del vehículo y sus rubros asociados.")
                .font(.subheadline)
                .foregroundStyle(SRIColors.textSecondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .sriContentSurface()
    }
}

#Preview {
    MatriculacionEmptyStateView()
}
