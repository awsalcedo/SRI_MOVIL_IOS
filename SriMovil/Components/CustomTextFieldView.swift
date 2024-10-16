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
    let onSearch: () -> Void
    
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
            
            // Botón de lupa siempre visible
            Button(action: {
                onSearch()  // Acción de búsqueda
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
            }
            .padding(.trailing, 10)
            .disabled(texto.isEmpty)  // Deshabilitar hasta que se ingresen 13 caracteres
            .opacity(texto.count == 13 ? 1.0 : 0.5)  // Cambiar la opacidad para que parezca desactivado
            
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
            CustomTextFieldView(texto: $texto, placeholder: "Ej: AAA0123", icono: "car.fill", onSearch: {})
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
