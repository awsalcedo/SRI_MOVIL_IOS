//
//  CustomTextFieldButtonView.swift
//  SriMovil
//
//  Created by usradmin on 10/10/24.
//

import SwiftUI

struct CustomTextFieldButtonView: View {
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
                .keyboardType(.numberPad) // Definir el teclado numérico si es necesario para RUC
                .onChange(of: texto) {
                    texto = String(texto.uppercased().prefix(13)) // Limitar a 13 caracteres
                }
            
            // Mostrar botón "X" para eliminar texto cuando no esté vacío
            if !texto.isEmpty {
                Button(action: {
                    texto = ""  // Limpiar el texto
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 5)
            }
            
            // Botón de lupa siempre visible
            Button(action: {
                onSearch()  // Acción de búsqueda
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
            }
            .padding(.trailing, 10)
            .disabled(texto.count != 13)  // Deshabilitar hasta que se ingresen 13 caracteres
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


struct CustomTextFieldButtonContainerView: View {
    @State private var texto: String = ""
    
    var body: some View {
        VStack {
            CustomTextFieldButtonView(texto: $texto, placeholder: "Ej: AAA0123", icono: "car.fill", onSearch: {})
                .padding(.top, 40)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct CustomTextFieldButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldButtonContainerView()
    }
}
