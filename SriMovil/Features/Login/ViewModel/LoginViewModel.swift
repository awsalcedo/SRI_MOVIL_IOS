//
//  LoginViewModel.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 23/4/26.
//

import Foundation
import Observation
import os

/// ViewModel responsable de la lógica de presentación de la feature Login.
///
/// `LoginViewModel` coordina:
/// - la carga del estado persistido de sesión,
/// - la autenticación del usuario,
/// - la persistencia segura de identidad y token,
/// - la reconstrucción de estados de UI equivalentes al flujo legacy,
/// - el cierre de sesión y cambio de usuario.
///
/// Esta implementación mantiene la arquitectura ya utilizada por otras features
/// del proyecto, conservando `ViewState` sin modificaciones y administrando
/// los valores del formulario directamente desde el ViewModel.
@Observable
@MainActor
final class LoginViewModel: LoginViewModelProtocol {
    
    // MARK: - Private Properties
    
    @ObservationIgnored
    private let loginInteractor: LoginInteractorProtocol
    
    @ObservationIgnored
    private let loadStoredSessionInteractor: LoadStoredSessionInteractorProtocol
    
    @ObservationIgnored
    private let logoutInteractor: LogoutInteractorProtocol
    
    @ObservationIgnored
    private let switchUserInteractor: SwitchUserInteractorProtocol
    
    @ObservationIgnored
    private let jwtDecoder: JWTDecoderProtocol
    
    @ObservationIgnored
    private let sessionStore: SessionStoreProtocol
    
    // MARK: - Properties
    
    /// Estado observable principal de la pantalla.
    var state: ViewState<LoginScreenModel> = .idle
    
    /// Identificación ingresada o conocida del contribuyente.
    var identificacion: String = ""
    
    /// Campo opcional de C.I. adicional mostrado en la UI.
    ///
    /// - Note:
    /// Actualmente este campo no participa en la autenticación remota.
    var ciAdicional: String = ""
    
    /// Contraseña ingresada por el usuario.
    ///
    /// - Important:
    /// Este valor solo debe vivir en memoria durante la interacción actual
    /// y debe limpiarse luego de un intento de autenticación.
    var contrasena: String = ""
    
    /// Controla si la contraseña se muestra en texto plano.
    var isPasswordVisible: Bool = false
    
    // MARK: - Initializers
    
    /// Crea una nueva instancia del ViewModel de Login.
    ///
    /// - Parameters:
    ///   - loginInteractor: Caso de uso encargado de autenticar al usuario.
    ///   - loadStoredSessionInteractor: Caso de uso encargado de reconstruir
    ///     la sesión persistida localmente.
    ///   - logoutInteractor: Caso de uso encargado de cerrar la sesión actual.
    ///   - switchUserInteractor: Caso de uso encargado de eliminar toda la
    ///     sesión persistida del usuario actual.
    ///   - jwtDecoder: Componente encargado de decodificar el payload del JWT.
    ///   - sessionStore: Store responsable de persistir identidad y autenticación.
    init(
        loginInteractor: LoginInteractorProtocol = LoginInteractor(),
        loadStoredSessionInteractor: LoadStoredSessionInteractorProtocol = LoadStoredSessionInteractor(),
        logoutInteractor: LogoutInteractorProtocol = LogoutInteractor(),
        switchUserInteractor: SwitchUserInteractorProtocol = SwitchUserInteractor(),
        jwtDecoder: JWTDecoderProtocol = JWTDecoder(),
        sessionStore: SessionStoreProtocol = KeychainSessionStore()
    ) {
        self.loginInteractor = loginInteractor
        self.loadStoredSessionInteractor = loadStoredSessionInteractor
        self.logoutInteractor = logoutInteractor
        self.switchUserInteractor = switchUserInteractor
        self.jwtDecoder = jwtDecoder
        self.sessionStore = sessionStore
    }
    
    // MARK: - Functions
    
    /// Carga el estado persistido de sesión al abrir la pantalla.
    func loadStoredSession() {
        do {
            let snapshot = try loadStoredSessionInteractor.loadStoredSession()
            
            identificacion = snapshot.identificacion ?? ""
            contrasena = ""
            
            let screenModel = LoginScreenModel(
                identificado: snapshot.identificado,
                autenticado: snapshot.autenticado,
                identificacionContribuyente: snapshot.identificacion,
                razonSocialContribuyente: snapshot.razonSocial
            )
            
            state = .success(screenModel)
        } catch {
            state = mapErrorToState(error)
        }
    }
    
    /// Ejecuta la autenticación del usuario.
    func autenticar() async {
        guard validateFields() else {
            return
        }
        
        state = .loading
        
        do {
            let authenticatedSession = try await loginInteractor.login(
                identificacion: effectiveIdentificacion,
                password: contrasena
            )
            
            let userProfile = try jwtDecoder.decode(token: authenticatedSession.accessToken)
            
            try sessionStore.saveIdentity(
                StoredIdentity(
                    identificacion: userProfile.identificacion,
                    razonSocial: userProfile.razonSocial
                )
            )
            
            try sessionStore.saveAuthentication(
                StoredAuthentication(
                    accessToken: authenticatedSession.accessToken,
                    validoHasta: userProfile.validoHasta
                )
            )
            
            identificacion = userProfile.identificacion
            contrasena = ""
            
            let screenModel = LoginScreenModel(
                identificado: true,
                autenticado: true,
                identificacionContribuyente: userProfile.identificacion,
                razonSocialContribuyente: userProfile.razonSocial
            )
            
            state = .success(screenModel)
        } catch {
            contrasena = ""
            state = mapErrorToState(error)
        }
    }
    
    /// Cierra la sesión actual manteniendo la identidad conocida.
    func cerrarSesion() {
        do {
            try logoutInteractor.logout()
            
            let snapshot = try loadStoredSessionInteractor.loadStoredSession()
            contrasena = ""
            
            let screenModel = LoginScreenModel(
                identificado: snapshot.identificado,
                autenticado: snapshot.autenticado,
                identificacionContribuyente: snapshot.identificacion,
                razonSocialContribuyente: snapshot.razonSocial
            )
            
            state = .success(screenModel)
        } catch {
            state = mapErrorToState(error)
        }
    }
    
    /// Elimina toda la información persistida de la sesión actual.
    func cambiarUsuario() {
        do {
            try switchUserInteractor.switchUser()
            
            identificacion = ""
            ciAdicional = ""
            contrasena = ""
            isPasswordVisible = false
            
            state = .success(
                LoginScreenModel(
                    identificado: false,
                    autenticado: false,
                    identificacionContribuyente: nil,
                    razonSocialContribuyente: nil
                )
            )
        } catch {
            state = mapErrorToState(error)
        }
    }
    
    /// Reinicia el estado observable principal de la pantalla.
    func resetState() {
        state = .idle
        isPasswordVisible = false
    }
    
    /// Alterna la visibilidad del campo de contraseña.
    func togglePasswordVisibility() {
        isPasswordVisible.toggle()
    }
    
    // MARK: - Private Functions
    
    /// Retorna el estado actual consolidado de la pantalla.
    ///
    /// Si el `state` todavía no tiene un valor exitoso, devuelve un modelo
    /// equivalente a un usuario no identificado.
    private var currentScreenModel: LoginScreenModel {
        switch state {
        case .success(let model):
            return model
        case .idle, .loading, .failure:
            return LoginScreenModel(
                identificado: false,
                autenticado: false,
                identificacionContribuyente: nil,
                razonSocialContribuyente: nil
            )
        }
    }
    
    /// Determina la identificación efectiva que debe utilizarse
    /// durante el proceso de autenticación.
    ///
    /// Si existe una identificación ingresada, se usa esa. Caso contrario,
    /// se utiliza la identificación persistida del contribuyente.
    private var effectiveIdentificacion: String {
        let identificacionIngresada = identificacion
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !identificacionIngresada.isEmpty {
            return identificacionIngresada
        }
        
        return currentScreenModel.identificacionContribuyente?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    /// Valida los campos requeridos antes de iniciar la autenticación.
    ///
    /// - Returns: `true` si la validación fue exitosa; caso contrario `false`.
    @discardableResult
    private func validateFields() -> Bool {
        let contrasenaLimpia = contrasena.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !currentScreenModel.identificado && effectiveIdentificacion.isEmpty {
            state = makeFailureState(.emptyIdentificacion)
            return false
        }
        
        if contrasenaLimpia.isEmpty {
            state = makeFailureState(.emptyPassword)
            return false
        }
        
        return true
    }
    
    /// Construye un estado de error de presentación para la UI.
    ///
    /// - Parameter error: Error de presentación específico de la feature Login.
    /// - Returns: Estado `.failure` listo para consumo por la vista.
    private func makeFailureState(_ error: LoginPresentationError) -> ViewState<LoginScreenModel> {
        .failure(
            message: error.localizedDescription,
            isInlineFieldError: error.isInlineFieldError
        )
    }
    
    /// Mapea errores de dominio, red o persistencia a `ViewState`.
    ///
    /// - Parameter error: Error capturado durante la ejecución del flujo.
    /// - Returns: Estado de error listo para consumo por la vista.
    private func mapErrorToState(_ error: Error) -> ViewState<LoginScreenModel> {
        
        if let networkError = error as? NetworkError {
            Logger.login.error("NetworkError: \(String(describing: networkError), privacy: .private)")
            
            switch networkError {
            case .unauthorized(let message):
                guard let message else {
                    return makeFailureState(.invalidCredentials)
                }
                
                if message.contains("ValidarTamanioClaveLoginException")
                    || message.contains("EmitidoLoginException")
                    || message.contains("ValidarClaveCaducadaLoginException") {
                    return makeFailureState(.expiredPassword)
                } else if message.contains("UsuarioBloqueadoException") {
                    return makeFailureState(.blockedPassword)
                } else if message.contains("InactivoLoginException") {
                    return makeFailureState(.inactivePassword)
                } else if message.contains("JBWEB000053") {
                    return makeFailureState(.invalidCredentials)
                } else {
                    return makeFailureState(.generic(message))
                }
                
            case .serverError:
                return makeFailureState(.unavailable)
                
            case .invalidURL,
                    .invalidResponse,
                    .badRequest,
                    .notFound,
                    .validateError,
                    .notAcceptable,
                    .unknown:
                return makeFailureState(.generic(AppStrings.Error.generic))
            }
            
        } else if let urlError = error as? URLError {
            Logger.login.error("URLError: \(urlError.code.rawValue, privacy: .public)")
            
            switch urlError.code {
            case .notConnectedToInternet:
                return makeFailureState(.generic(AppStrings.Error.network))
                
            case .timedOut:
                return makeFailureState(.generic(AppStrings.Error.timeout))
                
            case .cancelled:
                return state
                
            default:
                return makeFailureState(.generic(AppStrings.Error.generic))
            }
            
        } else {
            Logger.login.error("Unknown error: \(error.localizedDescription, privacy: .private)")
            return makeFailureState(.generic(AppStrings.Error.generic))
        }
    }
}

private extension LoginPresentationError {
    
    /// Indica si el error debe presentarse como error inline asociado
    /// a un campo o acción puntual del formulario.
    var isInlineFieldError: Bool {
        switch self {
        case .emptyIdentificacion,
             .emptyPassword,
             .invalidCredentials:
            return true
            
        case .blockedPassword,
             .inactivePassword,
             .expiredPassword,
             .unavailable,
             .generic:
            return false
        }
    }
}
