//
//  RucValidator.swift
//  SriMovil
//
//  Created by usradmin on 22/11/24.
//

import Foundation

protocol RucValidatorProtocol {
    /// Caso de uso para validar el tamaño del ruc y si es numérico.
    ///
    /// - Parameter ruc: El ruc a consultar de tipo `String`.
    /// - Returns: `Bool` .
    func validarRuc(_ ruc: String) -> Bool
}

struct RucValidator: RucValidatorProtocol {
    func validarRuc(_ ruc: String) -> Bool {
        let ruc = ruc.trimmingCharacters(in: .whitespacesAndNewlines)
        return ruc.count == 13 && ruc.allSatisfy(\.isNumber)
    }
}
