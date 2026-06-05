//
//  AppStrings.swift
//  SriMovil
//
//  Created by usradmin on 26/3/26.
//

import Foundation

enum AppStrings {
    
    enum Error {
        static let title = String(localized: "ERROR_TITLE")
        static let network = String(localized: "ERROR_NETWORK")
        static let timeout = String(localized: "ERROR_TIMEOUT")
        static let generic = String(localized: "ERROR_GENERIC")
        static let server = String(localized: "ERROR_SERVER")
        static let unauthorized = String(localized: "ERROR_UNAUTHORIZED")
        static let notFound = String(localized: "ERROR_NOT_FOUND")
    }
    
    enum Common {
        static let ok = String(localized: "COMMON_OK")
        static let retry = String(localized: "COMMON_RETRY")
        static let loading = String(localized: "COMMON_LOADING")
    }
    
    enum EstadoTributario {
        static let invalidRuc = String(localized: "ESTADO_TRIBUTARIO_RUC_INVALIDO")
    }
    
    enum Deudas {
        static let invalidRuc = String(localized: "DEUDAS_RUC_INVALIDO")
        static let invalidRucLength = String(localized: "DEUDAS_RUC_LONGITUD_INVALIDA")
        static let emptyRuc = String(localized: "DEUDAS_RUC_VACIO")
        
        static let emptyCedula = String(localized: "DEUDAS_CEDULA_VACIA")
        static let invalidCedula = String(localized: "DEUDAS_CEDULA_INVALIDA")
        
        static let emptyLastName = String(localized: "DEUDAS_APELLIDOS_VACIO")
    }
    
    enum Consultas {
        static let fileNotFound = String(localized: "CONSULTAS_FILE_NOT_FOUND")
        static let readFailed = String(localized: "CONSULTAS_READ_FAILED")
        static let decodingFailed = String(localized: "CONSULTAS_DECODING_FAILED")
    }
}
