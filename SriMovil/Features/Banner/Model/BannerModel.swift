//
//  BannerModel.swift
//  SriMovil
//
//  Created by usradmin on 21/4/26.
//

import Foundation

struct BannerModel: Codable, Equatable, Hashable, Sendable {
    let imagen64: String
    let url: String
    let predeterminado: Bool
}

extension BannerModel {
    
    /// Devuelve la URL válida asociada al banner, si existe.
    var destinationUrl: URL? {
        URL(string: url)
    }
    
    /// Decodifica la imagen Base64 del banner en datos binarios.
    ///
    /// El backend entrega el contenido en formato Data URL:
    /// `data:image/png;base64,...`
    ///
    /// Esta propiedad extrae únicamente el payload Base64 y lo convierte a `Data`
    /// para que la capa de UI pueda renderizar la imagen.
    var imageData: Data? {
        guard let base64Payload = imagen64.components(separatedBy: "base64,").last,
              base64Payload != imagen64 else {
            return nil
        }
        
        return Data(base64Encoded: base64Payload)
    }
}
