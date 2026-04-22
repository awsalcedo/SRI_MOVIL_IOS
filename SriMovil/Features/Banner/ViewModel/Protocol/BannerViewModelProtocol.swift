//
//  BannerViewModelProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 21/4/26.
//

import Foundation

@MainActor
protocol BannerViewModelProtocol: Observable {
    
    // MARK: Propiedades
    
    var state: ViewState<BannerModel> {get set}
    
    // MARK: Funciones
    
    func obtenerBanner() async
    func resetState()
}
