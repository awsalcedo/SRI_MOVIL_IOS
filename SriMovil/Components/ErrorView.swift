//
//  ErrorView.swift
//  SriMovil
//
//  Created by usradmin on 14/10/24.
//

import SwiftUI

struct ErrorView: View {
    let error: String
    
    var body: some View {
        ZStack {
            /*Color.red
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)*/
            
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                
                Text(error.description)
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
            }
            .padding()
            .background(Color.red.opacity(0.9))
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding()
        }
    }
}

#Preview {
    ErrorView(error: "La identificación ingresada no se encuentra registrada en nuestra base de datos, verifique y vuelva a intentar")
}
