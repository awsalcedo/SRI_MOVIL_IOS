//
//  SRIPrimaryButtonStyle.swift
//  SriMovil
//
//  Created by usradmin on 27/3/26.
//

import SwiftUI

struct SRIPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 25)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(SRIColors.primary.opacity(configuration.isPressed ? 0.85 : 1))
            )
    }
}
