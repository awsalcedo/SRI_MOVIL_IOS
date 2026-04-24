//
//  LoginViewData.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import Foundation

/// Representa los datos de presentación de la pantalla de login.
///
/// Este modelo contiene la información que la UI necesita renderizar
/// de forma estable, independientemente del estado transitorio de carga,
/// éxito o error representado por `ViewState`.
///
/// - Important:
/// Este tipo no reemplaza a `ViewState`, sino que representa el contenido
/// persistente de la pantalla de login.
struct LoginViewData: Equatable, Sendable {
    
    /// Identificación ingresada o conocida del contribuyente.
    var identificacion: String = ""
    
    /// Campo opcional de C.I. adicional mostrado en la UI.
    var ciAdicional: String = ""
    
    /// Contraseña ingresada por el usuario.
    var contrasena: String = ""
    
    /// Indica si la app ya conoce la identidad del contribuyente.
    var identificado: Bool = false
    
    /// Indica si existe una autenticación activa y vigente.
    var autenticado: Bool = false
    
    /// Identificación persistida del contribuyente.
    var identificacionContribuyente: String?
    
    /// Razón social persistida del contribuyente.
    var razonSocialContribuyente: String?
}
