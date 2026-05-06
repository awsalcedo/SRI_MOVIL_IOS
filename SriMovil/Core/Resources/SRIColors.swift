//
//  SRIColors.swift
//  SriMovil
//
//  Created by usradmin on 27/3/26.
//

import SwiftUI

enum SRIColors {
    static let primary = Color("SRIPrimaryColor")
    static let primaryLight = Color("SRIPrimaryLightColor")
    static let textPrimary = Color("SRITextPrimaryColor")
    static let textSecondary = Color("SRITextSecondaryColor")
    static let border = Color("SRIBorderColor")
    static let error = Color("SRIErrorColor")
    static let background = Color("SRIBackgroundColor")
    static let surface = Color("SRISurfaceColor")
    static let cardBackground = Color("SRICardBackgroundColor")
    static let surfaceSecondary = Color("SRISurfaceSecondaryColor")
    
    // MARK: - Semantic Background Accents
    
    static let backgroundBlue = Color(red: 0.12, green: 0.42, blue: 0.78)
    static let backgroundBlueLight = Color(red: 0.64, green: 0.80, blue: 0.94)
    
    static let backgroundBlueAccent = backgroundBlue.opacity(0.22)
    static let backgroundBlueAccentSoft = backgroundBlueLight.opacity(0.20)
    
    // MARK: - Icon Accents
    
    static let cardIconBlue = Color(red: 0.05, green: 0.36, blue: 0.78)
    static let secondaryIconBlue = Color(red: 0.08, green: 0.32, blue: 0.72)
}
