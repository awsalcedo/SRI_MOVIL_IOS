//
//  URLRequest.swift
//  SriMovil
//
//  Created by usradmin on 1/10/24.
//

import Foundation

public extension URLRequest {
    /**
     Crea y devuelve una solicitud `URLRequest` con el método HTTP GET.
     
     - Parameters:
     - url: El `URL` al que se realizará la solicitud GET.
     - token: Token opcional para la autorización. Si se proporciona, se añadirá al encabezado de la solicitud.
     - authMethod: Método de autorización a utilizar. Por defecto es `.token`.
     
     - Returns: Una solicitud `URLRequest` configurada con el método GET y los encabezados correspondientes.
     
     ### Ejemplo de uso:
     ```swift
     let url = URL(string: "https://api.example.com/data")!
     let request = URLRequest.get(url: url, token: "YOUR_TOKEN_HERE")
     ```
     */
    static func get(url:URL, token:String? = nil, authMethod:AuthorizationMethod = .token) -> URLRequest {
        var request = URLRequest(url: url)
        if let token {
            request.setValue("\(authMethod.rawValue) \(token)",
                             forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = HTTPMethods.get.rawValue
        request.timeoutInterval = 30
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        return request
    }
    
    /**
     Crea y devuelve una solicitud `URLRequest` con el método HTTP especificado, comúnmente POST, y un cuerpo JSON.
     
     - Parameters:
     - url: El `URL` al que se realizará la solicitud.
     - data: Datos `JSON` que se enviarán en el cuerpo de la solicitud.
     - method: Método HTTP a utilizar. Por defecto es `.post`.
     - token: Token opcional para la autorización. Si se proporciona, se añadirá al encabezado de la solicitud.
     - authMethod: Método de autorización a utilizar. Por defecto es `.token`.
     - encoder: Instancia del `encoder` que puede ser sobrecargada para cambiar cualquier configuración.
     
     - Returns: Una solicitud `URLRequest` configurada con el método HTTP especificado, los encabezados correspondientes y el cuerpo JSON.
     
     ### Ejemplo de uso:
     ```swift
     struct UserData: Codable {
     let name: String
     let age: Int
     }
     
     let url = URL(string: "https://api.example.com/user")!
     let userData = UserData(name: "John", age: 30)
     let request = URLRequest.post(url: url, data: userData, token: "YOUR_TOKEN_HERE")
     ```
     */
    static func post<JSON:Codable>(url: URL, data: JSON, method: HTTPMethods = .post,
                                   token: String? = nil, authMethod: AuthorizationMethod = .token,
                                   encoder: JSONEncoder = JSONEncoder()) -> URLRequest {
        var request = URLRequest(url: url)
        if let token {
            request.setValue("\(authMethod.rawValue) \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = method.rawValue
        request.timeoutInterval = 30
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? encoder.encode(data)
        return request
    }
}
