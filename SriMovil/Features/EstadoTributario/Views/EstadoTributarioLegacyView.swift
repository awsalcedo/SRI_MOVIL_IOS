//
//  EstadoTributarioLegacyView.swift
//  SriMovil
//
//  Created by usradmin on 8/6/26.
//

/// Vista que representa la pantalla legada de "Estado Tributario" implementada en SwiftUI.
///
/// Esta pantalla conserva la estructura visual de la versión original:
/// cabecera superior, título, campo de ingreso del RUC y botón principal
/// de consulta.
///
/// La lógica de negocio debe delegarse posteriormente al `ViewModel`
/// correspondiente, respetando la arquitectura limpia de la aplicación.
import SwiftUI

struct EstadoTributarioLegacyView: View {
    
    // MARK: - Properties
    
    /// Acción del entorno que permite cerrar la pantalla actual.
    @Environment(\.dismiss) private var dismiss
    
    /// RUC ingresado por el usuario.
    @State private var ruc = ""
    @State private var lastQueriedRuc = ""
    
    // MARK: - State
    
    @State private var viewModel: EstadoTributarioViewModel
    
    // MARK: - Initializers
    
    init(interactor: EstadoTributarioInteractorProtocol = EstadoTributarioInteractor()) {
        self.viewModel = EstadoTributarioViewModel(interactor: interactor)
    }
    
    // MARK: - Computed Properties
    
    private var isInlineFieldError: Bool {
        viewModel.isInlineFieldError
    }
    
    private var isConsultButtonDisabled: Bool {
        ruc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading
    }
    
    var body: some View {
        VStack(spacing: 0) {
            LegacyChildHeaderView(
                onBack: {
                    dismiss()
                },
                onMenu: {
                    // TODO: Mostrar menú de opciones.
                }
            )
            .frame(maxWidth: .infinity)
            
            content
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .navigationBarBackButtonHidden(true)
    }
    
    /// Contenido principal de la pantalla.
    private var content: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Estado Tributario")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color(red: 0.10, green: 0.28, blue: 0.48))
                .padding(.top, 24)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("RUC:")
                    .font(.system(size: 20))
                    .foregroundStyle(Color(red: 0.25, green: 0.29, blue: 0.33))
                
                TextField("Ej: 1700000000001", text: $ruc)
                    .keyboardType(.numberPad)
                    .font(.system(size: 20))
                    .italic()
                    .padding(.horizontal, 12)
                    .frame(height: 44)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.12), radius: 3, x: 0, y: 1)
            }
            
            Button {
                lastQueriedRuc = ruc.trimmingCharacters(in: .whitespacesAndNewlines)
                Task {
                    await viewModel.obtenerEstadoTributario(ruc: ruc)
                }
            } label: {
                Text("Consultar")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color(red: 0.02, green: 0.02, blue: 0.68))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.white.opacity(0.35), lineWidth: 1)
                    )
            }
            .padding(.horizontal, 18)
            .padding(.top, 8)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    EstadoTributarioLegacyView()
}
