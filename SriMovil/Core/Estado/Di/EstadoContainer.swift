//
//  EstadoContainer.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation
import Factory

extension Container {
    
    var estadoApi: Factory<EstadoApiType> {
        self { EstadoApi() }.singleton
    }
    
    var estadoRepository: Factory<EstadoRepositoryType> {
        self { EstadoRepository() }.singleton
    }
    
    var estadoRemoteDataSource: Factory<EstadoRemoteDataSourceType> {
        self { EstadoRemoteDataSource() }.singleton
    }
    
    var estadoLocalDataSource: Factory<EstadoLocalDataSourceType> {
        self { EstadoLocalDataSource() }.singleton
    }
}
