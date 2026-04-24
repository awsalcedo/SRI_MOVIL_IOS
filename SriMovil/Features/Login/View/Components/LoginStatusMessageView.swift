//
//  LoginStatusMessageView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import SwiftUI

/// Define el tipo de mensaje de estado mostrado en la pantalla de login.
///
/// Este enum permite diferenciar visualmente entre:
/// - errores provocados por validación o ingreso del usuario,
/// - errores de sistema o disponibilidad,
/// - errores inline asociados a un campo específico.
enum LoginStatusMessageKind {
    
    /// Error atribuible a una acción o dato ingresado por el usuario.
    ///
    /// Ejemplo:
    /// - identificación y/o clave incorrectas.
    case errorUser
    
    /// Error de sistema o de disponibilidad del servicio.
    ///
    /// Ejemplo:
    /// - no se puede realizar la autenticación en este momento.
    case errorSystem
    
    /// Error inline asociado a un campo del formulario.
    ///
    /// Ejemplo:
    /// - campo requerido vacío.
    case inlineError
}

/// Define una acción opcional asociada a un mensaje de estado.
enum LoginStatusMessageAction {
    
    /// Muestra un botón con una acción asociada.
    ///
    /// - Parameters:
    ///   - title: Título del botón.
    ///   - action: Acción a ejecutar al pulsar el botón.
    case button(title: String, action: () -> Void)
}

/// Vista reutilizable para presentar mensajes de estado en la pantalla de login.
///
/// Este componente permite mostrar mensajes de error o advertencia de forma
/// consistente con la jerarquía visual de la interfaz.
///
/// - Important:
/// Los mensajes asociados a errores del usuario se presentan con mayor énfasis
/// visual que los errores de sistema, siguiendo una semántica más cercana al
/// comportamiento recomendado en interfaces nativas de iOS.
struct LoginStatusMessageView: View {
    
    let message: String
    let kind: LoginStatusMessageKind
    let action: LoginStatusMessageAction?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label {
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(textColor)
                    .fixedSize(horizontal: false, vertical: true)
            } icon: {
                Image(systemName: iconName)
                    .foregroundStyle(iconColor)
            }
            
            if let action {
                switch action {
                case .button(let title, let action):
                    Button(title, action: action)
                        .font(.subheadline.weight(.semibold))
                        .buttonStyle(.plain)
                        .foregroundStyle(actionColor)
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.thinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(borderColor, lineWidth: 1)
        )
    }
    
    // MARK: - Private Properties
    
    private var iconName: String {
        switch kind {
        case .errorUser, .errorSystem:
            return "exclamationmark.triangle.fill"
        case .inlineError:
            return "exclamationmark.circle.fill"
        }
    }
    
    private var textColor: Color {
        switch kind {
        case .errorUser, .inlineError:
            return .red
        case .errorSystem:
            return SRIColors.textPrimary
        }
    }
    
    private var actionColor: Color {
        switch kind {
        case .errorUser, .inlineError:
            return .red
        case .errorSystem:
            return SRIColors.primary
        }
    }
    
    private var iconColor: Color {
        switch kind {
        case .errorUser, .inlineError:
            return .red
        case .errorSystem:
            return .orange.opacity(0.85)
        }
    }
    
    private var borderColor: Color {
        switch kind {
        case .errorUser, .inlineError:
            return Color.red.opacity(0.22)
        case .errorSystem:
            return Color.orange.opacity(0.18)
        }
    }
}

#Preview("Estados") {
    ScrollView {
        VStack(spacing: 20) {
            LoginStatusMessageView(
                message: "No se puede realizar la autenticación en este momento.",
                kind: .errorSystem,
                action: nil
            )
            
            LoginStatusMessageView(
                message: "La identificación y/o clave no son correctas.",
                kind: .inlineError,
                action: nil
            )
            
            LoginStatusMessageView(
                message: "Clave bloqueada. Accede a la opción para recuperar clave.",
                kind: .errorSystem,
                action: .button(
                    title: "Recuperar clave",
                    action: {}
                )
            )
            
            LoginStatusMessageView(
                message: "Tu clave debe actualizarse para continuar.",
                kind: .errorSystem,
                action: .button(
                    title: "Actualizar clave",
                    action: {}
                )
            )
        }
        .padding(20)
    }
    .background(SRIColors.background)
}
