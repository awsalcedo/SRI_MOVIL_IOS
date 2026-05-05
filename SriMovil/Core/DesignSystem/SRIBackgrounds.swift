//
//  SRIBackgrounds.swift
//  SriMovil
//
//  Created by usradmin on 5/5/26.
//

import SwiftUI

enum SRIBackgrounds {
    
    static var mainGradient: some View {
        LinearGradient(
            stops: [
                .init(color: SRIColors.backgroundBlue.opacity(0.22), location: 0.00),
                .init(color: SRIColors.backgroundBlueLight.opacity(0.22), location: 0.25),
                .init(color: SRIColors.background, location: 0.58),
                .init(color: SRIColors.background, location: 1.00)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
    
    static var formGradient: some View {
        LinearGradient(
            stops: [
                .init(color: SRIColors.backgroundBlue.opacity(0.14), location: 0.00),
                .init(color: SRIColors.backgroundBlueLight.opacity(0.14), location: 0.28),
                .init(color: SRIColors.background, location: 0.62),
                .init(color: SRIColors.background, location: 1.00)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
