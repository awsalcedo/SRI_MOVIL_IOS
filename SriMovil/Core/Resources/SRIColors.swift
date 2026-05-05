//
//  SRIColors.swift
//  SriMovil
//
//  Created by usradmin on 27/3/26.
//

import SwiftUI

enum SRIColors {
    static let primary = Color("PrimaryColor")
    static let primaryLight = Color("PrimaryColorLight")
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
    static let border = Color("BorderColor")
    static let error = Color("ErrorColor")
    static let background = Color("BackgroundColor")
    static let surface = Color("SurfaceColor")
    static let cardBackground = Color("CardBackgroundColor")
    static let surfaceSecondary = Color("SurfaceSecondaryColor")
    
    // MARK: - Semantic Background Accents
    
    /// Acento institucional sutil para fondos decorativos.
    ///
    /// Se usa con baja opacidad para mantener una apariencia nativa,
    /// ligera y alineada con las Human Interface Guidelines de Apple.
    static let backgroundBlueAccent = primaryLight.opacity(0.10)
    
    /// Variante más suave del acento institucional para transiciones
    /// o degradados de fondo.
    static let backgroundBlueAccentSoft = primaryLight.opacity(0.04)
}
