//
//  LoginInteractor.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Implementación concreta del caso de uso de login.
///
/// `LoginInteractor` es responsable de:
/// - construir la solicitud de autenticación a partir de las credenciales,
/// - delegar la ejecución HTTP al `NetworkServiceProtocol`,
/// - transformar la respuesta remota (`LoginResponseDTO`) en un modelo
///   limpio de la feature (`AuthenticatedSessionModel`).
final class LoginInteractor: LoginInteractorProtocol {
    
    //MARK: - Propiedades Privadas
    
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Inicializadores
    
    /// Crea una nueva instancia del interactor de login.
    ///
    /// - Parameter networkService: Servicio de red utilizado para consumir
    ///   el endpoint de autenticación. Por defecto utiliza `NetworkService`.
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Funciones
    
    /// Ejecuta el proceso de autenticación del usuario utilizando Basic Auth.
    ///
    /// Este endpoint no requiere body JSON; las credenciales se envían
    /// mediante el header `Authorization`.
    ///
    /// - Parameters:
    ///   - identificacion: Identificación ingresada por el usuario.
    ///   - password: Contraseña ingresada por el usuario.
    ///
    /// - Returns: Sesión autenticada con el token procesado.
    ///
    /// - Throws:
    ///   - `NetworkError` para errores HTTP conocidos o problemas de respuesta.
    ///   - Errores de transporte o decodificación propagados desde la capa de red.
    func login(identificacion: String, password: String) async throws -> AuthenticatedSessionModel {
        let dto: LoginResponseDTO = try await networkService.post(
            url: .login,
            auth: .basic(identificacion: identificacion.uppercased(), password: password)
        )
        return dto.toDomain()
    }
}
