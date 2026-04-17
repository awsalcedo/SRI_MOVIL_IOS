//
//  MatriculacionLoadingStateView.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import SwiftUI

struct MatriculacionLoadingStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
                .controlSize(.large)
                .tint(SRIColors.primary)
            
            Text("Consultando información del vehículo")
                .font(.headline)
                .foregroundStyle(SRIColors.textPrimary)
            
            Text("Esto puede tardar unos segundos.")
                .font(.subheadline)
                .foregroundStyle(SRIColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .sriContentSurface()
    }
}

#Preview {
    MatriculacionLoadingStateView()
}
