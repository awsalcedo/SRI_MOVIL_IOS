//
//  VehiculosApiType.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

protocol VehiculosApiProtocol {
    func makeRequest(endPoint: EndPoint) async -> Result<Data, HttpClientError>
}
