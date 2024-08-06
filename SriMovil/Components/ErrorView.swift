//
//  ErrorView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct ErrorView: View {
    let error: InfoVehiculoDomainError
    
    var body: some View {
        ZStack {
            Color.red
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
            
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
            }
            .padding()
            .background(Color.red.opacity(0.9))
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding()
        }
    }
}

extension InfoVehiculoDomainError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "La URL proporcionada no es válida."
        case .requestFailed(let description):
            return "La solicitud falló con el error: \(description)"
        case .clientError(let description):
            return "Error del cliente: \(description)"
        case .serverError(let description):
            return "Error del servidor: \(description)"
        case .decodingError(let description):
            return "Error de decodificación: \(description)"
        case .unknownError:
            return "Ocurrió un error desconocido."
        case .parsingError(let description):
            return "Error de análisis: \(description)"
        case .statusError(let statusCode):
            return "Error con el código de estado: \(statusCode)"
        case .generico:
            return "Ocurrió un error inesperado. Por favor, inténtalo de nuevo."
        case .vehiculoNoEncontrado(let message):
            return message
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: .requestFailed("No se pudo conectar al servidor."))
    }
}
