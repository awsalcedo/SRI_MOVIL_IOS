//
//  LoginInteractorProtocol.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 22/4/26.
//

import Foundation

/// Define el contrato del caso de uso de autenticación.
///
/// Este protocolo abstrae la operación de login para desacoplar
/// la capa de presentación de la implementación concreta que consume
/// el endpoint remoto de autenticación.
protocol LoginInteractorProtocol: Sendable {
    
    /// Ejecuta la autenticación del usuario contra el backend.
    ///
    /// - Parameters:
    ///   - identificacion: Identificación ingresada por el usuario.
    ///   - password: Contraseña ingresada por el usuario.
    ///
    /// - Returns: Resultado autenticado con el token limpio.
    ///
    /// - Throws:
    ///   - `NetworkError` para errores HTTP conocidos.
    ///   - Errores de transporte o decodificación propagados
    ///     desde la capa de networking.
    func login(identificacion: String, password: String) async throws -> AuthenticatedSessionModel
}
