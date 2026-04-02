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
        
        // MARK: Deudas
        
        static func deudasPorIdentificacion(identificacion: String, tipoPersona: String) -> String {
            "movil-servicios/api/v1.0/deudas/porIdentificacion/\(identificacion)?tipoPersona=\(tipoPersona)"
        }
        
        static func deudasPorNombre(nombre: String, tipoPersona: String, resultados: Int) -> String {
            "movil-servicios/api/v1.0/deudas/porDenominacion/\(nombre)?tipoPersona=\(tipoPersona)&resultados=\(resultados)"
        }
    }
}
