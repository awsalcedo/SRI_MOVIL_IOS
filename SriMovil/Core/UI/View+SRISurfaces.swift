//
//  View+SRISurfaces.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import SwiftUI

extension View {
    
    func sriTopSurface() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(.regularMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .strokeBorder(.white.opacity(0.18))
            )
            .shadow(color: .black.opacity(0.06), radius: 20, y: 10)
    }
    
    func sriContentSurface() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.white.opacity(0.72))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .strokeBorder(.white.opacity(0.24))
            )
    }
    
    func sriHighlightSurface() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(SRIColors.primary.opacity(0.08))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .strokeBorder(SRIColors.primary.opacity(0.18))
            )
    }
}
