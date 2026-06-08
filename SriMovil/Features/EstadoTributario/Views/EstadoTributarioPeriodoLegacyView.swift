//
//  DetalleEstadoPeriodoLegacyView.swift
//  SriMovil
//
//  Created by usradmin on 8/6/26.
//

import SwiftUI

/// Vista legacy que presenta los períodos de una obligación pendiente.
///
/// Esta pantalla replica visualmente la pantalla legada `detalleEstPeriodoPage`,
/// utilizando el modelo `ObligacionesPendientesModel` ya existente.
///
/// La vista no modifica modelos ni ejecuta lógica de negocio. Solo presenta
/// la descripción de la obligación y sus períodos asociados.
struct EstadoTributarioPeriodoLegacyView: View {
    
    // MARK: - Environment
    
    /// Acción del entorno que permite cerrar la pantalla actual.
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Properties
    
    /// Obligación pendiente seleccionada desde la pantalla de detalle.
    let obligacionPendiente: ObligacionesPendientesModel
    
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
            
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    titleView
                    
                    Divider()
                    
                    Text("PERIODOS:")
                        .font(.system(size: 17))
                        .foregroundStyle(Color(red: 0.20, green: 0.23, blue: 0.26))
                    
                    periodsListView
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Private Views
    
    /// Título con la descripción de la obligación pendiente.
    private var titleView: some View {
        Text(obligacionPendiente.descripcion)
            .font(.system(size: 22, weight: .bold))
            .foregroundStyle(Color(red: 0.10, green: 0.28, blue: 0.48))
            .padding(.top, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// Lista de períodos equivalente al `ul data-bind="foreach: periodos"`.
    private var periodsListView: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(obligacionPendiente.periodos, id: \.self) { periodo in
                HStack(alignment: .top, spacing: 8) {
                    Text("•")
                    Text(periodo)
                }
                .font(.system(size: 16))
                .foregroundStyle(Color(red: 0.20, green: 0.23, blue: 0.26))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    let obligacionPendiente = ObligacionesPendientesModel(
        descripcion: "1024 IMPUESTO A LA RENTA REGIMEN IMPOSITIVO PARA MICROEMPRESAS",
        periodos: [
            "SEGUNDO SEMESTRE 2020",
            "PRIMER SEMESTRE 2021",
            "SEGUNDO SEMESTRE 2021"
        ]
    )
    
    NavigationStack {
        EstadoTributarioPeriodoLegacyView(
            obligacionPendiente: obligacionPendiente
        )
    }
}
