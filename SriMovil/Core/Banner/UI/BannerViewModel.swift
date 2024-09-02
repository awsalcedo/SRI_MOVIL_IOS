//
//  ObtenerBannerViewModel.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation
import Factory

enum ViewState<T: Equatable>: Equatable {
    case inicial
    case cargando
    case cargado(T)
    case error(String)
}

class BannerViewModel: ObservableObject {
    
    @Injected(\.obtenerBannerUsecase) private var useCase
    @Published var estado: ViewState<BannerModel> = .inicial
    
    @MainActor
    func obtenerBanner() {
        estado = .cargando
        
        Task {
            //print(Thread.current) //Observamos en la consola que se está ejecutando en el hilo 1 que es el principal
            let result = await useCase.excecute()
            
            switch result {
            case .success(let banner):
                self.estado = .cargado(banner)
            case .failure(let error):
                self.estado = .error("Error al cargar el banner: \(error.localizedDescription)")
            }
            
            /*DispatchQueue.main.async {
             switch result {
             case .success(let banner):
             self.estado = .cargado(banner)
             case .failure(let error):
             self.estado = .error("Error al cargar el banner: \(error.localizedDescription)")
             }
             }*/
        }
    }
}
