//
//  BannerHeroView.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import SwiftUI

struct BannerHeroView: View {
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: SRICornerRadius.hero, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            SRIColors.primary,
                            SRIColors.primaryLight
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 188)
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "building.columns.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.white.opacity(0.14))
                        .padding(20)
                }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("SRIMOVIL")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.95))
                
                Text("Consulta servicios tributarios y vehiculares de forma rápida y segura.")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.white)
                    .lineLimit(3)
                
                Text("Próximamente este espacio mostrará banners informativos dinámicos.")
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.88))
            }
            .padding(20)
        }
        .padding(.horizontal, SRISpacing.large)
    }
}

#Preview {
    BannerHeroView()
        .padding(.vertical)
        .background(SRIColors.background)
}
