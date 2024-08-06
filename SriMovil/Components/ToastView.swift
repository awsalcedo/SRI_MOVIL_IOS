//
//  ToastView.swift
//  SriMovil
//
//  Created by usradmin on 6/8/24.
//

import SwiftUI

struct ToastView: View {
    let message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                Text(message)
                    .font(.subheadline)
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .transition(.slide)
                    .animation(.easeInOut, value: isShowing)
            }
        }
        .padding()
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(message: "Este es un mensaje de error", isShowing: .constant(true))
    }
}
