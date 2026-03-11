//
//  EstadoTributarioApi.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 5/10/24.
//

import Foundation

struct EstadoTributarioApi: EstadoTributarioApiProtocol {
    
    /*private let network: SriNetworkProtocol
    
    init(network: SriNetworkProtocol = SriNetwork.shared) {
        self.network = network
    }
    
    
    
    func makeRequest(endPoint: EndPoint) async throws -> EstadoTributarioDTO {
        do {
            return try await network.getJSON(endPoint: endPoint, type: EstadoTributarioDTO.self, decoder: JSONDecoder())
        } catch {
            //throw SriNetworkError.json(error)
            throw error
        }
    }*/
    
    
    private let network: SriApiClientProtocol
    init(network: SriApiClientProtocol = SriApiClient.shared) {
        self.network = network
    }
    
    func makeRequest(ruc: String) async throws -> EstadoTributarioDTO {
        do {
            let url = SriAPIUrl.estadoTributarioURL.appendingPathComponent(ruc)
            return try await network.getRequest(url: url, responseType: EstadoTributarioDTO.self, authType: .none)
        } catch {
            throw error
        }
    }
    
}
