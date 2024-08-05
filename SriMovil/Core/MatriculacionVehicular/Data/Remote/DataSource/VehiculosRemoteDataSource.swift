//
//  VehiculosRemoteDataSource.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation
import Factory

// Componente que se encarga de implementar los detalles de infraestructura para realizar las peticiones al Core de servicios del SRIMOVIL

class VehiculosRemoteDataSource: VehiculosRemoteDataSourceType {
    @Injected(\.vehiculosApi) private var api
    
    func obtenerInfoVehiculo(idVehiculo: String) async -> Result<InfoVehiculoModel, HttpClientError> {
        let endPoint = EndPoint(
            baseURL: "https://srienlinea.sri.gob.ec/",
            context: "movil-servicios/api/",
            path: "v1.0/matriculacion/valor/\(idVehiculo)",
            queryParameters: nil,
            bodyParameters: nil,
            method: .get
        )
        
        let result = await api.makeRequest(endPoint: endPoint)
        
        switch result {
        case .success(let data):
            do {
                let infoVehiculoDto = try JSONDecoder().decode(InfoVehiculoDto.self, from: data)
                // Transforma el DTO a tu modelo de dominio
                let infoVehiculoModel = InfoVehiculoModel(from: infoVehiculoDto)
                return .success(infoVehiculoModel)
            } catch {
                return .failure(.decodingError(error))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
