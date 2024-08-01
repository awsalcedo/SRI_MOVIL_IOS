//
//  BarraProgresoView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct BarraProgresoView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.5)
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                Text("Cargando...")
                    .foregroundColor(.blue)
                    .font(.headline)
                    .padding(.top, 10)
            }
        }
    }
}

#Preview {
    BarraProgresoView()
}
