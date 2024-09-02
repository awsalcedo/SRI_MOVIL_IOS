//
//  BannerRepository.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation
import Factory

class BannerRepository: BannerRepositoryType {
    @Injected(\.bannerRemoteDataSource) private var remoteDataSource
    @Injected(\.bannerLocalDataSource) private var localDataSource
    @Injected(\.estadoLocalDataSource) private var estadoLocalDataSource
    @Injected(\.errorBannerMapper) private var errorMapper
    
    func obtenerBanner() async -> Result<BannerModel, BannerDomainError> {
        do {
            if let estado = try estadoLocalDataSource.obtenerEstado() {
                let fechaBanner = estado.fechaBanner
                let fechaActual = Int(Date().timeIntervalSince1970 * 1000)
                
                if fechaBanner > fechaActual {
                    return await obtenerYGuardarBannerDeFormaRemota()
                } else {
                    return try obtenerBannerDeFormaLocal()
                }
            } else {
                return await obtenerYGuardarBannerDeFormaRemota()
            }
        } catch {
            return .failure(.unknownError)
        }
    }
    
    private func obtenerYGuardarBannerDeFormaRemota() async -> Result<BannerModel, BannerDomainError> {
        let remoteBanner = await remoteDataSource.obtenerBanner()
        
        switch remoteBanner {
        case .success(let bannerModel):
            do {
                // Guardar el banner obtenido de forma remota en la base de datos local
                try localDataSource.guardarBanner(banner: bannerModel)
                
                // Obtiene el EstadoDto desde la API o del localDataSource
                if let estadoDto = try? estadoLocalDataSource.obtenerEstado() {
                    try actualizarFechaBannerEnEstado(desde: estadoDto)
                } else {
                    // Maneja el caso donde no se pudo obtener el EstadoDto
                    throw CoreDataError.entityNotFound
                }
                
                return .success(bannerModel)
            } catch {
                return .failure(.unknownError)
            }
        case .failure(let error):
            let domainError = errorMapper.map(error: error)
            return .failure(domainError)
        }
    }
    
    
    private func obtenerBannerDeFormaLocal() throws -> Result<BannerModel, BannerDomainError> {
        if let localBanner = try localDataSource.obtenerBanner() {
            return .success(localBanner)
        } else {
            return .failure(.noDataAvailable)
        }
    }
    
    private func actualizarFechaBannerEnEstado(desde estadoDto: EstadoDto) throws {
        if var estado = try estadoLocalDataSource.obtenerEstado() {
            // Actualiza las fechas con los valores obtenidos de la API
            estado.fechaBanner = estadoDto.fechaBanner
            estado.fechaEstado = estadoDto.fechaEstado
            estado.fechaInfoAgencias = estadoDto.fechaInfoAgencias
            
            try estadoLocalDataSource.guardarEstado(estado)
        } else {
            // Si no existe el estado, crea uno nuevo con los valores obtenidos de la API
            try estadoLocalDataSource.guardarEstado(estadoDto)
        }
    }
}
