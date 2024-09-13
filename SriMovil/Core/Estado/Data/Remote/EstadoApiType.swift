//
//  EstadoApiType.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation

protocol EstadoApiType {
    func makeRequest(endPoint: EndPoint) async -> Result<Data, HttpClientError>
}