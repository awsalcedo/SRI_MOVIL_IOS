//
//  LegacyChildHeaderView.swift
//  SriMovil
//
//  Created by usradmin on 8/6/26.
//

import SwiftUI

/// Cabecera reutilizable para pantallas hijas con diseño legado.
///
/// Replica la barra superior azul de la aplicación anterior, incluyendo
/// el botón de regreso en el lado izquierdo y el botón de opciones en el
/// lado derecho.
struct LegacyChildHeaderView: View {
    
    /// Acción ejecutada al presionar el botón de regreso.
    let onBack: () -> Void
    
    /// Acción ejecutada al presionar el botón de opciones.
    let onMenu: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                backButton
                Spacer()
            }
            .padding(.leading, 8)
            
            HStack {
                Spacer()
                menuButton
            }
            .padding(.trailing, 8)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 72)
        .background(Color(red: 0.02, green: 0.02, blue: 0.68))
    }
    
    /// Botón de regreso ubicado en el lado izquierdo de la cabecera.
    private var backButton: some View {
        Button(action: onBack) {
            HStack(spacing: 6) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 24, weight: .bold))
                
                Text("Volver")
                    .font(.system(size: 20, weight: .bold))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 10)
            .frame(height: 48)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white.opacity(0.35), lineWidth: 1)
            )
        }
    }
    
    /// Botón de opciones ubicado en el lado derecho de la cabecera.
    private var menuButton: some View {
        Button(action: onMenu) {
            Image(systemName: "ellipsis")
                .font(.system(size: 24, weight: .bold))
                .rotationEffect(.degrees(90))
                .foregroundStyle(.white)
                .frame(width: 44, height: 48)
        }
    }
}

#Preview {
    LegacyChildHeaderView(
        onBack: {},
        onMenu: {}
    )
}
