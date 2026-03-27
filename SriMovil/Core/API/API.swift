//
//  API.swift
//  SriMovil
//
//  Created by usradmin on 25/3/26.
//

import Foundation

enum API {
    
    static let baseURL = "https://srienlinea.sri.gob.ec/"
    
    enum Endpoints {
        
        // MARK: - Matriculacion Vehicular
        
        static let matriculacionVehicular = "movil-servicios/api/v1.0/matriculacion/valor/"
        
        // MARK: - Estado Tributario
        
        static func estadoTributario(ruc: String) -> String {
            "movil-servicios/api/v1.0/estadoTributario/\(ruc)"
        }
    }
}
