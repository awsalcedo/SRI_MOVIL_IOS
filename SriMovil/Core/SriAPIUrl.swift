//
//  URL.swift
//  SriMovil
//
//  Created by usradmin on 12/11/24.
//

import Foundation

/// Enumeración que agrupa las url's para facilitar el mantenimiento
enum SriAPIUrl {
    static let main = URL(string: "https://srienlinea.sri.gob.ec/")!
    static let matriculacionVehicularURL = main.appending(path: "movil-servicios/api/v1.0/matriculacion/valor/")
    static let estadoTributarioURL = main.appending(path: "movil-servicios/api/v1.0/estadoTributario")
}
