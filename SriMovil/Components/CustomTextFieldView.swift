//
//  CustomTextFieldView.swift
//  SriMovil
//
//  Created by usradmin on 6/8/24.
//

import SwiftUI

struct CustomTextFieldView: View {
    @Binding var texto: String
    let placeholder: String
    let icono: String
    
    var body: some View {
        HStack {
            Image(systemName: icono)
                .foregroundColor(.gray)
                .padding(.leading, 10)
            
            TextField(placeholder, text: $texto)
                .padding(.vertical, 10)
                .padding(.horizontal, 5)
                .cornerRadius(8)
                .onChange(of: texto) {
                    texto = String(texto.uppercased().prefix(40))
                }
            
        }
        .padding(.horizontal, 10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        //.padding(.horizontal, 20)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}


struct CustomTextFieldContainerView: View {
    @State private var texto: String = ""
    
    var body: some View {
        VStack {
            CustomTextFieldView(texto: $texto, placeholder: "Ej: AAA0123", icono: "car.fill")
                .padding(.top, 40)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldContainerView()
    }
}
