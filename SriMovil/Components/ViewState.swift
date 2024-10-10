//
//  ViewState.swift
//  SriMovil
//
//  Created by usradmin on 9/10/24.
//

import Foundation

enum ViewStates<T> {
    case idle // Estado inicial, sin hacer nada
    case loading // Mientras se cargan los datos
    case success(T) // Cuando los datos se cargan correctamente
    case failure(String) // En caso de error
}
