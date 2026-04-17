//
//  InlineErrorMessageView.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import SwiftUI

struct InlineErrorMessageView: View {
    let message: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "exclamationmark.circle.fill")
                .font(.footnote)
                .foregroundStyle(SRIColors.error)
            
            Text(message)
                .font(.footnote)
                .foregroundStyle(SRIColors.error)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview("Mensaje corto") {
    InlineErrorMessageView(
        message: "RUC inválido"
    )
    .padding()
    .background(SRIColors.background)
}

#Preview("Mensaje largo") {
    InlineErrorMessageView(
        message: "El número ingresado no corresponde a un RUC válido. Verifica la información e inténtalo nuevamente."
    )
    .padding()
    .background(SRIColors.background)
}

#Preview("Multilínea extrema") {
    InlineErrorMessageView(
        message: "Error de validación: el identificador ingresado no cumple con el formato requerido por el sistema del SRI. Por favor revisa e intenta nuevamente."
    )
    .padding()
    .background(SRIColors.background)
}

#Preview("Dark Mode") {
    InlineErrorMessageView(
        message: "El identificador ingresado no es válido"
    )
    .padding()
    .background(SRIColors.background)
    .preferredColorScheme(.dark)
}

#Preview("Dark Mode largo") {
    InlineErrorMessageView(
        message: "El número ingresado no corresponde a un identificador válido. Verifica la información e inténtalo nuevamente."
    )
    .padding()
    .background(SRIColors.background)
    .preferredColorScheme(.dark)
}
