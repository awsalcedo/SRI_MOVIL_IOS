//
//  LoginViewModelProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import Foundation
import Observation

/// Define el contrato del ViewModel de la feature Login.
///
/// Este protocolo abstrae la lógica de presentación de la pantalla,
/// incluyendo:
/// - carga de sesión persistida,
/// - autenticación,
/// - cierre de sesión,
/// - cambio de usuario,
/// - manejo del formulario.
@MainActor
protocol LoginViewModelProtocol: Observable {
    
    // MARK: - Properties
    
    /// Estado observable principal de la pantalla.
    var state: ViewState<LoginScreenModel> { get set }
    
    /// Identificación ingresada en el formulario.
    var identificacion: String { get set }
    
    /// Campo opcional de C.I. adicional.
    var ciAdicional: String { get set }
    
    /// Contraseña ingresada por el usuario.
    var contrasena: String { get set }
    
    /// Indica si la contraseña debe mostrarse en texto plano.
    var isPasswordVisible: Bool { get set }
    
    // MARK: - Functions
    
    /// Carga el estado persistido de sesión.
    func loadStoredSession()
    
    /// Ejecuta la autenticación del usuario.
    func autenticar() async
    
    /// Cierra la sesión actual.
    func cerrarSesion()
    
    /// Elimina la sesión persistida para permitir cambiar de usuario.
    func cambiarUsuario()
    
    /// Reinicia el estado observable de la pantalla.
    func resetState()
    
    /// Alterna la visibilidad del campo de contraseña.
    func togglePasswordVisibility()
}
