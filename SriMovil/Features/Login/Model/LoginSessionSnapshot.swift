//
//  LoginSessionSnapshot.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Representa el estado reconstruido de la sesión local al abrir la feature.
///
/// Este modelo sirve para traducir la persistencia local en un estado
/// entendible por la capa de presentación.
struct LoginSessionSnapshot: Equatable, Sendable {
    
    /// Indica si existe una identidad conocida del contribuyente.
    let identificado: Bool
    
    /// Indica si existe una autenticación activa y vigente.
    let autenticado: Bool
    
    /// Identificación conocida del contribuyente.
    let identificacion: String?
    
    /// Razón social conocida del contribuyente.
    let razonSocial: String?
}
