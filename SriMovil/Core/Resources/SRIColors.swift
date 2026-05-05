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
    
    static let backgroundBlue = Color(red: 0.12, green: 0.42, blue: 0.78)
    static let backgroundBlueLight = Color(red: 0.64, green: 0.80, blue: 0.94)
    
    static let backgroundBlueAccent = backgroundBlue.opacity(0.22)
    static let backgroundBlueAccentSoft = backgroundBlueLight.opacity(0.20)
    
    // MARK: - Icon Accents
    
    static let cardIconBlue = Color(red: 0.05, green: 0.36, blue: 0.78)
    static let secondaryIconBlue = Color(red: 0.08, green: 0.32, blue: 0.72)
}
