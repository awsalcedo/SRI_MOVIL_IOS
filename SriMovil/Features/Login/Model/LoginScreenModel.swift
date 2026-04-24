//
//  LoginScreenModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import Foundation

/// Representa el estado consolidado de la pantalla de login.
///
/// Este modelo contiene la información que la UI necesita para renderizar
/// los distintos modos funcionales de la feature:
/// - usuario no identificado,
/// - usuario identificado pero no autenticado,
/// - usuario identificado y autenticado.
///
/// - Important:
/// Este modelo se utiliza como payload de `ViewState` en la feature Login.
/// Los valores efímeros del formulario, como la contraseña en edición,
/// se gestionan directamente en el ViewModel.
struct LoginScreenModel: Equatable, Sendable {
    
    /// Indica si la aplicación conoce la identidad del contribuyente.
    let identificado: Bool
    
    /// Indica si existe una autenticación activa y vigente.
    let autenticado: Bool
    
    /// Identificación persistida del contribuyente.
    let identificacionContribuyente: String?
    
    /// Razón social persistida del contribuyente.
    let razonSocialContribuyente: String?
}
