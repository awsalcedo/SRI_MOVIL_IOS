//
//  StoredIdentity.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Representa la identidad conocida del contribuyente persistida localmente.
///
/// Este modelo se utiliza para conservar información básica del usuario
/// incluso cuando ya no existe una autenticación activa.
///
/// - Important:
/// Este tipo no representa una sesión autenticada. Solo almacena
/// datos de identidad previamente obtenidos desde un token válido.
struct StoredIdentity: Codable, Sendable, Equatable {
    let identificacion: String
    let razonSocial: String
}
