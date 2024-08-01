//
//  FormatterUtils.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct FormatterUtils {
    static func formattedCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "es_EC") // Cambia esto según tu región
        formatter.currencySymbol = "$" // Asegúrate de usar el símbolo de moneda correcto
        
        if let formattedValue = formatter.string(from: NSNumber(value: value)) {
            return formattedValue
        } else {
            return "$0.00"
        }
    }
}
