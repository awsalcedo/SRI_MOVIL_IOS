//
//  VehiculosApi.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

class VehiculosApi: VehiculosApiProtocol {
  
    private let network: SriNetworkProtocol
    
    init(network: SriNetworkProtocol = SriNetwork.shared) {
        self.network = network
    }
    
    func makeRequest(endPoint: EndPoint) async throws -> InfoVehiculoDto {
        do {
            return try await network.getJSON(endPoint: endPoint, type: InfoVehiculoDto.self, decoder: JSONDecoder())
        } catch {
            //throw SriNetworkError.json(error)
            throw error
        }
    }
}
