//
//  EstadoTributarioApi.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

struct EstadoTributarioApi: EstadoTributarioApiProtocol {
    
    private let network: SriNetworkProtocol
    
    init(network: SriNetworkProtocol = SriNetwork.shared) {
        self.network = network
    }
    
    func makeRequest(endPoint: EndPoint) async throws -> EstadoTributarioDTO {
        
        do {
            return try await network.getJSON(endPoint: endPoint, type: EstadoTributarioDTO.self, decoder: JSONDecoder())
        } catch {
            throw SriNetworkError.json(error)
        }
        
    }
}
