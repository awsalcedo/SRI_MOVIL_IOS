//
//  BannerHeroView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 17/4/26.
//

import SwiftUI
import Observation

struct BannerHeroView: View {
    
    // MARK: - Constantes
    
    private enum Layout {
        static let height: CGFloat = 118
        static let cornerRadius: CGFloat = 22
        static let innerHorizontalPadding: CGFloat = 0
    }
    
    // MARK: - Propiedades
    
    @State private var viewModel = BannerViewModel()
    @Environment(\.openURL) private var openURL
    
    // MARK: - Body
    
    var body: some View {
        content
            .frame(maxWidth: .infinity)
            .task {
                if case .idle = viewModel.state {
                    await viewModel.obtenerBanner()
                }
            }
    }
    
    // MARK: - Content
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            placeholderBannerView
            
        case .success(let banner):
            if let imageData = banner.imageData,
               let uiImage = UIImage(data: imageData) {
                dynamicBannerView(uiImage: uiImage, url: banner.destinationUrl)
            } else {
                fallbackBannerView
            }
            
        case .failure:
            fallbackBannerView
        }
    }
    
    // MARK: - Subviews
    
    private var placeholderBannerView: some View {
        heroContainer {
            LinearGradient(
                colors: [
                    SRIColors.primary.opacity(0.92),
                    SRIColors.primaryLight.opacity(0.82)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 10) {
                    ProgressView()
                        .tint(.white)
                    
                    Text("Cargando banner informativo...")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.white.opacity(0.92))
                }
                .padding(20)
            }
        }
        .redacted(reason: .placeholder)
    }
    
    @ViewBuilder
    private func dynamicBannerView(uiImage: UIImage, url: URL?) -> some View {
        if let url {
            Button {
                openURL(url)
            } label: {
                remoteBannerImage(uiImage)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Banner informativo")
            .accessibilityHint("Abre información relacionada")
        } else {
            remoteBannerImage(uiImage)
        }
    }
    
    private func remoteBannerImage(_ uiImage: UIImage) -> some View {
        bannerImageContainer {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func bannerImageContainer<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        let shape = RoundedRectangle(
            cornerRadius: Layout.cornerRadius,
            style: .continuous
        )
        
        return ZStack {
            // Fondo similar al color dominante del banner remoto.
            // Evita que se vean cortes o vacíos blancos dentro del marco.
            Color(red: 0.60, green: 0.90, blue: 0.96)
            
            content()
                .padding(.horizontal, Layout.innerHorizontalPadding)
        }
        .frame(maxWidth: .infinity)
        .frame(height: Layout.height)
        .clipShape(shape)
        .overlay {
            shape
                .strokeBorder(SRIColors.border.opacity(0.14), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.035), radius: 10, x: 0, y: 5)
        .contentShape(shape)
    }
    
    private var fallbackBannerView: some View {
        heroContainer {
            LinearGradient(
                colors: [
                    SRIColors.primary,
                    SRIColors.primaryLight
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(alignment: .topTrailing) {
                Image(systemName: "building.columns.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white.opacity(0.14))
                    .padding(20)
            }
            .overlay(alignment: .bottomLeading) {
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
        }
    }
    
    // MARK: - Helpers
    
    private func heroContainer<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        let shape = RoundedRectangle(
            cornerRadius: Layout.cornerRadius,
            style: .continuous
        )
        
        return content()
            .frame(maxWidth: .infinity)
            .frame(height: Layout.height)
            .background(SRIColors.cardBackground)
            .clipShape(shape)
            .overlay {
                shape
                    .strokeBorder(SRIColors.border.opacity(0.18), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.045), radius: 10, x: 0, y: 5)
            .contentShape(shape)
    }
}

#Preview {
    BannerHeroView()
        .padding(.vertical)
        .background(SRIColors.background)
}
