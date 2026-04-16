//
//  SSLPinningDelegate.swift
//  SriMovil
//
//  Created by usradmin on 25/3/26.
//

import Foundation
import CryptoKit
import os

/// Delegate de `URLSession` encargado de implementar SSL Pinning.
///
/// Este componente valida que la clave pública del servidor coincida con
/// un conjunto de hashes previamente definidos (`pinnedHashes`), garantizando
/// que la aplicación solo se comunique con servidores confiables.
///
/// El proceso de validación consiste en:
/// 1. Obtener el certificado del servidor.
/// 2. Extraer la clave pública.
/// 3. Calcular el hash SHA-256.
/// 4. Compararlo con los hashes configurados.
///
/// - Important:
/// SSL Pinning es una medida de seguridad crítica que protege contra ataques
/// de tipo Man-in-the-Middle (MITM).
///
/// - Note:
/// Puede deshabilitarse en ambientes de desarrollo o testing mediante
/// `isPinningEnabled = false`, pero debe estar habilitado en producción.
final class SSLPinningDelegate: NSObject, URLSessionDelegate, Sendable {
    
    // MARK: - Propiedades Privadas
        
    /// Conjunto de hashes SHA-256 de las claves públicas confiables del servidor.
    ///
    /// Estos hashes deben ser generados previamente y almacenados de forma segura.
    private let pinnedHashes: Set<String>
    
    /// Indica si el mecanismo de SSL Pinning está habilitado.
    ///
    /// Permite desactivar la validación en entornos de desarrollo o pruebas.
    private let isPinningEnabled: Bool
    
    // MARK: - Inicializador
        
    /// Inicializa el delegate de SSL Pinning.
    ///
    /// - Parameters:
    ///   - pinnedHashes: Conjunto de hashes SHA-256 válidos.
    ///   - isPinningEnabled: Indica si el pinning está activo. Por defecto `true`.
    ///
    /// - Note:
    /// En producción, `pinnedHashes` debe contener los hashes reales del backend.
    init(pinnedHashes: Set<String>, isPinningEnabled: Bool = true) {
        self.pinnedHashes = pinnedHashes
        self.isPinningEnabled = isPinningEnabled
        super.init()
    }
    
    // MARK: - URLSessionDelegate
        
    /// Maneja los desafíos de autenticación SSL durante la conexión HTTPS.
    ///
    /// Este método intercepta el proceso de validación del certificado del servidor
    /// y aplica la lógica de SSL Pinning.
    ///
    /// - Parameters:
    ///   - session: La sesión que recibió el desafío.
    ///   - challenge: El desafío de autenticación enviado por el servidor.
    ///   - completionHandler: Callback que indica cómo proceder con la validación.
    ///
    /// Flujo de validación:
    /// 1. Si el pinning está deshabilitado → se delega al sistema (`default handling`).
    /// 2. Se verifica que el método sea `serverTrust`.
    /// 3. Se obtiene el certificado del servidor.
    /// 4. Se extrae la clave pública.
    /// 5. Se calcula el hash SHA-256.
    /// 6. Se compara contra los hashes permitidos.
    ///
    /// - Important:
    /// Si el hash no coincide, la conexión se cancela inmediatamente.
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        guard isPinningEnabled else {
            completionHandler(.performDefaultHandling, nil)
            return
        }
        
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        guard let serverCertificate = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate],
              let certificate = serverCertificate.first else {
            Logger.core.error("SSL Pinning: No server certificate found")
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Extract public key data and compute SHA-256 hash
        let serverPublicKeyData = SecCertificateCopyKey(certificate)
        guard let publicKeyData = serverPublicKeyData,
              let publicKeyExternalRepresentation = SecKeyCopyExternalRepresentation(publicKeyData, nil) as? Data else {
            Logger.core.error("SSL Pinning: Failed to extract public key")
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        let serverHash = SHA256.hash(data: publicKeyExternalRepresentation)
            .compactMap { String(format: "%02x", $0) }
            .joined()
        
        if pinnedHashes.contains(serverHash) {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            Logger.core.warning("SSL Pinning: Server public key hash mismatch")
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
