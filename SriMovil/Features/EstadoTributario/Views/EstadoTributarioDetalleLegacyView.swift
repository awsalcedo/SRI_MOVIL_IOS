//
//  EstadoTributarioDetalleLegacyView.swift
//  SriMovil
//
//  Created by usradmin on 8/6/26.
//

import SwiftUI

/// Vista legacy que presenta el detalle del estado tributario.
///
/// Esta pantalla replica visualmente la pantalla legada de Apache Cordova.
/// Cuando no existe detalle, muestra un mensaje secundario con ícono informativo,
/// equivalente al partial legacy `mensajeSecundario`.
struct EstadoTributarioDetalleLegacyView: View {
    
    // MARK: - Environment
    
    /// Acción del entorno que permite cerrar la pantalla actual.
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Properties
    
    /// Información del estado tributario a presentar.
    let infoEstadoTributario: EstadoTributarioModel?
    
    /// Mensaje que se muestra cuando no existe detalle disponible.
    let mensajeSecundario: String
    
    // MARK: - State
    
    /// Obligación pendiente seleccionada para navegar hacia la pantalla de períodos.
    @State private var obligacionSeleccionada: ObligacionesPendientesModel?
    
    // MARK: - Initializers
    
    /// Crea una vista legacy de detalle de estado tributario.
    ///
    /// - Parameters:
    ///   - infoEstadoTributario: Información del estado tributario a presentar.
    ///   - mensajeSecundario: Mensaje mostrado cuando no existe detalle.
    init(
        infoEstadoTributario: EstadoTributarioModel?,
        mensajeSecundario: String = "No existe información para presentar."
    ) {
        self.infoEstadoTributario = infoEstadoTributario
        self.mensajeSecundario = mensajeSecundario
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            LegacyChildHeaderView(
                onBack: {
                    dismiss()
                },
                onMenu: {
                    // TODO: Mostrar menú superior legacy.
                }
            )
            
            contentView
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .navigationBarBackButtonHidden(true)
        .navigationDestination(item: $obligacionSeleccionada) { obligacion in
            EstadoTributarioPeriodoLegacyView(
                obligacionPendiente: obligacion
            )
        }
    }
    
    // MARK: - Private Views
    
    /// Contenido principal de la pantalla.
    @ViewBuilder
    private var contentView: some View {
        if let infoEstadoTributario {
            detailContentView(infoEstadoTributario)
        } else {
            messageSecondaryView
        }
    }
    
    /// Mensaje secundario equivalente al partial legacy `mensajeSecundario`.
    private var messageSecondaryView: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(Color(red: 0.10, green: 0.28, blue: 0.48))
                    .frame(width: 44, alignment: .center)
                
                Text(mensajeSecundario)
                    .font(.system(size: 15))
                    .foregroundStyle(Color(red: 0.20, green: 0.23, blue: 0.26))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(12)
            .background(.white)
            .overlay {
                Rectangle()
                    .stroke(Color.gray.opacity(0.35), lineWidth: 1)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            
            Spacer()
        }
    }
    
    /// Contenido de detalle cuando existe información tributaria.
    ///
    /// - Parameter infoEstadoTributario: Información del estado tributario.
    /// - Returns: Vista con el detalle legacy.
    private func detailContentView(
        _ infoEstadoTributario: EstadoTributarioModel
    ) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text(infoEstadoTributario.razonSocial)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color(red: 0.10, green: 0.28, blue: 0.48))
                    .padding(.top, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                detailGridView(infoEstadoTributario)
                
                if let obligacionesPendientes = infoEstadoTributario.obligacionesPendientes,
                   !obligacionesPendientes.isEmpty {
                    obligationsListView(obligacionesPendientes)
                }
                
                Divider()
                    .padding(.top, 8)
                
                Text("El tiempo reflejado en el Plazo de Vigencia de los Documentos, corresponde al tiempo que tendrá vigencia los documentos impresos el día de hoy.")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
    }
    
    /// Grilla 50/50 equivalente a `ui-grid-a gridDetalle contenedor5050`.
    private func detailGridView(
        _ infoEstadoTributario: EstadoTributarioModel
    ) -> some View {
        VStack(spacing: 0) {
            detailRow(
                title: "ESTADO TRIBUTARIO:",
                value: infoEstadoTributario.descripcion.displayValue
            )
            
            detailRow(
                title: "PLAZO DE VIGENCIA DE DOCUMENTOS:",
                value: infoEstadoTributario.plazoVigenciaDoc
            )
            
            detailRow(
                title: "CLASE DE CONTRIBUYENTE:",
                value: infoEstadoTributario.claseContribuyente
            )
        }
        .background(.white)
        .overlay {
            Rectangle()
                .stroke(Color.gray.opacity(0.35), lineWidth: 1)
        }
    }
    
    /// Construye una fila de detalle en formato 50/50.
    private func detailRow(title: String, value: String) -> some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color(red: 0.20, green: 0.23, blue: 0.26))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
            
            Text(value)
                .font(.system(size: 14))
                .foregroundStyle(Color(red: 0.20, green: 0.23, blue: 0.26))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
        }
        .overlay {
            Rectangle()
                .stroke(Color.gray.opacity(0.25), lineWidth: 0.5)
        }
    }
    
    /// Construye la lista de obligaciones pendientes equivalente a `listviewCompleto`.
    private func obligationsListView(
        _ obligacionesPendientes: [ObligacionesPendientesModel]
    ) -> some View {
        VStack(spacing: 0) {
            Text("OBLIGACIONES PENDIENTES:")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(Color(red: 0.02, green: 0.02, blue: 0.68))
            
            ForEach(obligacionesPendientes) { obligacionPendiente in
                obligationRow(obligacionPendiente)
                Divider()
            }
        }
        .overlay {
            Rectangle()
                .stroke(Color.gray.opacity(0.35), lineWidth: 1)
        }
    }
    
    /// Construye una fila de obligación pendiente.
    @ViewBuilder
    private func obligationRow(
        _ obligacionPendiente: ObligacionesPendientesModel
    ) -> some View {
        if obligacionPendiente.periodos.isEmpty {
            Text(obligacionPendiente.descripcion)
                .font(.system(size: 15))
                .foregroundStyle(Color(red: 0.10, green: 0.28, blue: 0.48))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .background(.white)
        } else {
            Button {
                obligacionSeleccionada = obligacionPendiente
            } label: {
                HStack(spacing: 8) {
                    Text(obligacionPendiente.descripcion)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(red: 0.10, green: 0.28, blue: 0.48))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.gray)
                }
                .padding(12)
                .background(.white)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview("Con detalle") {
    let obligacionesPendientes: [ObligacionesPendientesModel] = [
        ObligacionesPendientesModel(
            descripcion: "CONTRIBUYENTE MANTIENE DEUDAS FIRMES",
            periodos: []
        ),
        ObligacionesPendientesModel(
            descripcion: "1024 IMPUESTO A LA RENTA REGIMEN IMPOSITIVO PARA MICROEMPRESAS",
            periodos: [
                "SEGUNDO SEMESTRE 2020",
                "PRIMER SEMESTRE 2021",
                "SEGUNDO SEMESTRE 2021"
            ]
        )
    ]
    
    let estadoTributario = EstadoTributarioModel(
        ruc: "1003360144001",
        razonSocial: "TORRES SANTACRUZ VANESSA XIMENA",
        descripcion: .obligacionesPendientes,
        plazoVigenciaDoc: "0 meses",
        claseContribuyente: "Régimen RIMPE negocios populares",
        obligacionesPendientes: obligacionesPendientes
    )
    
    NavigationStack {
        EstadoTributarioDetalleLegacyView(
            infoEstadoTributario: estadoTributario
        )
    }
}

#Preview("Sin detalle") {
    NavigationStack {
        EstadoTributarioDetalleLegacyView(
            infoEstadoTributario: nil,
            mensajeSecundario: "No se encontró información del estado tributario para el RUC ingresado."
        )
    }
}
