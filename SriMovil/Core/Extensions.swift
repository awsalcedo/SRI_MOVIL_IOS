//
//  Extensions.swift
//  SriMovil
//
//  Created by usradmin on 1/10/24.
//

import Foundation

public extension URLSession {
    /// La llamada a `dataRequest` está provocada para que se devuelva el error ``SriNetworkError`` directamente como un `catch` de la llamada de `URLSession.data` para mayor comodidad a la hora de implementar. Esta sería la versión `from` que recibe una `URL` para realizar la petición.
    /// - Parameter url: `URL` que se recibe para hacer la petición
    /// - Returns: Devuelve una tupla `(Data, URLResponse)` con los datos en bruto de la petición y la respuesta de tipo `URLResponse` que normalmente deberá ser casteada a `HTTPURLResponse` de la manera conveniente.
    func dataRequest(from url:URL) async throws -> (Data, URLResponse) {
        do {
            return try await data(from: url)
        } catch {
            throw SriNetworkError.general(error)
        }
    }
    
    /// La llamada a `dataRequest` está provocada para que se devuelva el error ``SriNetworkError`` directamente como un `catch` de la llamada de `URLSession.data` para mayor comodidad a la hora de implementar. Esta sería la versión `for` que recibe una `URLRequest`.
    /// - Parameter url: `URL` que se recibe para hacer la petición
    /// - Returns: Devuelve una tupla `(Data, URLResponse)` con los datos en bruto de la petición y la respuesta de tipo `URLResponse` que normalmente deberá ser casteada a `HTTPURLResponse` de la manera conveniente.
    func dataRequest(for request:URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await data(for: request)
        } catch {
            throw SriNetworkError.general(error)
        }
    }
}
