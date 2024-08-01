//
//  ButtonPersonalizadoView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct ButtonPersonalizadoView: View {
    var title: String
    var backgroundColor: Color = Color.blue // Color de fondo por defecto azul
    var textColor: Color = Color.white // Color del texto por defecto blanco
    var action: () -> Void // Acción a realizar al pulsar el botón
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .font(.headline) // Puedes ajustar el tamaño de la fuente según tus necesidades
                .foregroundColor(textColor) // Color del texto
                .padding()
                .background(backgroundColor) // Color de fondo
                .cornerRadius(10) // Radio de esquina para redondear el botón
                .shadow(radius: 5) // Agregar una sombra para darle profundidad
        }
    }
}

#Preview {
    ButtonPersonalizadoView(title: "Consultar", action: {})
}
