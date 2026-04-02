//
//  SRIColors.swift
//  SriMovil
//
//  Created by usradmin on 27/3/26.
//

import SwiftUI

enum SRIColors {
    
    static let primary = Color(hex: "#0401a9") // usa el azul fuerte exacto del manual en tu catálogo/asset - #0C5974
    static let textPrimary = Color(hex: "#434A54") // gris fuerte institucional
    static let textSecondary = Color(hex: "#AAB2BD") // gris neutro institucional
    static let border = Color(hex: "#CCD1D9")
    static let error = Color(hex: "#D64545").opacity(0.8) // o el rojo/coral definido en el manual
    static let background = Color(.systemGroupedBackground)
    static let surface = Color(.secondarySystemGroupedBackground)
    static let cardBackground = Color(.systemBackground)
    
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
