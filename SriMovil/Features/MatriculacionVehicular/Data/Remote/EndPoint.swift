//
//  EndPoint.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

public struct EndPoint {
    let baseURL: String = "https://srienlinea.sri.gob.ec/"
    let context: String = "movil-servicios/api/"
    let path: String
    let queryParameters: [String: String]?
    let bodyParameters: [String: Any]?
    let method: HTTPMethod
    
    var url: URL? {
        return URL(string: baseURL + context + path)
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]?) {
        guard let parameters = parameters else { return }
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}

extension URLRequest {
    mutating func setHTTPBody(with parameters: [String: Any]?) {
        guard let parameters = parameters else { return }
        do {
            self.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            self.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            print("Error serializing HTTP body: \(error.localizedDescription)")
        }
    }
}
