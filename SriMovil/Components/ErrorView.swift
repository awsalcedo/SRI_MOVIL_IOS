//
//  ErrorView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct ErrorView: View {
    let message: String

    var body: some View {
        VStack {
            Text("Error")
                .font(.title)
                .foregroundColor(.red)
            Text(message)
                .padding()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ErrorView(message: "No es posible obtener la información del vehículo")
}
