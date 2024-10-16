//
//  SriNetwork.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

protocol SriNetworkProtocol {
    func getJSON<JSON: Codable>(endPoint: EndPoint, type: JSON.Type, decoder: JSONDecoder?) async throws -> JSON
    func post(request: URLRequest, statusOK: Int) async throws
}

public final class SriNetwork: SriNetworkProtocol, @unchecked Sendable {
    
    /// Variable de tipo Singleton que almacena la clase persistida de SriNetwork
    public static let shared = SriNetwork()
    
    
    /// Función `getJSON` que recuperará cualquier `JSON` de manera genérica usando el protocolo `Codable`.
    ///
    ///  La llamada a la función `getJSON` devolverá el resultado de forma genérica para cualquier tipo de elemento `JSON` que se quiera recuperar. Por ejemplo, si queremos recuperar el *array* de `EstadoTributarioDTO` solo hay que hacer una llamada como esta:
    ///  ```swift
    ///     getJSON(endPoint: endPoint, type: EstadoTributarioDTO.self)
    ///  ```
    ///
    ///  - Parameters:
    ///     - endPoint: Ttipo `EndPoint` utilizado para la petición.
    ///     - type: Tipo del `JSON` que vamos a devolver.
    ///     - decoder: Instancia del `decoder` que puede ser sobrecargada para cambiar cualquier configuración.
    ///
    ///  - Returns: El tipo genérico del `JSON` en el tipo `type` que será decodificado.
    ///  - Throws: El tipo ``SriNetworkError`` que nos informará del error que haya podido darse en la llamada.
    public func getJSON<JSON: Codable>(endPoint: EndPoint,
                                       type: JSON.Type,
                                       decoder: JSONDecoder? = JSONDecoder()) async throws -> JSON {
        
        // Asegurarse de que `decoder` no sea opcional
        let actualDecoder = decoder ?? JSONDecoder()
        
        guard var urlComponents = URLComponents(string: endPoint.baseURL + endPoint.context + endPoint.path) else {
            throw SriNetworkError.badURL
        }
        
        urlComponents.setQueryItems(with: endPoint.queryParameters)
        
        guard let url = urlComponents.url else {
            throw SriNetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.setHTTPBody(with: endPoint.bodyParameters)
        
        let (data, response) = try await URLSession.shared.dataRequest(for: request)
        
        guard let response = response as? HTTPURLResponse else { throw SriNetworkError.noHTTP }
        
        /*if response.statusCode == 200 {
         do {
         return try actualDecoder.decode(JSON.self, from: data)
         } catch {
         throw SriNetworkError.json(error)
         }
         } else {
         throw SriNetworkError.status(response.statusCode)
         }*/
        
        switch response.statusCode {
        case 200...299:
            // Decodificación del JSON en caso de éxito
            do {
                return try actualDecoder.decode(JSON.self, from: data)
            } catch {
                throw SriNetworkError.json(error)
            }
        case 400...499:
            // Manejo de errores del cliente
            let apiError = try? actualDecoder.decode(ErrorResponse.self, from: data)
            throw SriNetworkError.clientError(apiError?.mensaje ?? "Error del cliente", response.statusCode)
        case 500...599:
            // Manejo de errores del servidor
            let apiError = try? actualDecoder.decode(ErrorResponse.self, from: data)
            throw SriNetworkError.serverError(apiError?.mensaje ?? "Error del servidor", response.statusCode)
            
        default:
            throw SriNetworkError.status(response.statusCode)
        }
        
        
    }
    
    /// Función `post` que realiza una solicitud POST.
    ///
    /// - Parameters:
    ///     - request: Tipo `URLRequest` utilizado para la petición.
    ///     - statusOK: Código de estado HTTP que se considera exitoso. Por defecto es 200.
    ///
    /// - Throws: El tipo ``SriNetworkError`` que nos informará del error que haya podido darse en la llamada.
    public func post(request:URLRequest, statusOK:Int = 200) async throws {
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else { throw SriNetworkError.noHTTP }
        
        if response.statusCode != statusOK {
            throw SriNetworkError.status(response.statusCode)
        }
    }
}
