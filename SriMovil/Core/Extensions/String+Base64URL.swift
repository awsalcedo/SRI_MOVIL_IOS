//
//  String+Base64URL.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import Foundation

extension String {
    
    /// Convierte una cadena en formato Base64URL a `Data`.
    ///
    /// JWT utiliza Base64URL en lugar de Base64 estándar. Esta utilidad
    /// normaliza la cadena para permitir su decodificación con `Data(base64Encoded:)`.
    var base64URLDecodedData: Data? {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let remainder = base64.count % 4
        if remainder > 0 {
            base64 += String(repeating: "=", count: 4 - remainder)
        }
        
        return Data(base64Encoded: base64)
    }
}
