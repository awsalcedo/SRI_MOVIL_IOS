//
//  EstadoTributarioDetalleView.swift
//  SriMovil
//
//  Created by usradmin on 9/10/24.
//

import SwiftUI

// MARK: - Body

struct EstadoTributarioDetalleView: View {
    
    let infoEstadoTributario: EstadoTributarioModel
    @State private var obligacionSeleccionada: ObligacionesPendientesModel?
    
    var body: some View {
        VStack(spacing: 16) {
            summaryCard
            
            if let obligacionesPendientes = infoEstadoTributario.obligacionesPendientes,
               !obligacionesPendientes.isEmpty {
                obligationsCard(obligacionesPendientes)
            }
            
            footerNote
        }
        .sheet(item: $obligacionSeleccionada) { obligacion in
            DetalleObligacionSheetView(
                obligacionPendiente: obligacion,
                cerrarSheet: { obligacionSeleccionada = nil }
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }
    
    // MARK: - Private Views
    
    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(infoEstadoTributario.razonSocial)
                .font(.title2.weight(.bold))
                .foregroundStyle(SRIColors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 14) {
                DetailRow(label: "RUC", value: infoEstadoTributario.ruc)
                DetailRow(label: "Razón social", value: infoEstadoTributario.razonSocial)
                DetailRow(label: "Estado tributario", value: infoEstadoTributario.descripcion.displayValue)
                DetailRow(label: "Plazo vigencia", value: infoEstadoTributario.plazoVigenciaDoc)
                DetailRow(label: "Clase de contribuyente", value: infoEstadoTributario.claseContribuyente)
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(SRIColors.border.opacity(0.7), lineWidth: 0.8)
        }
        .shadow(color: .black.opacity(0.03), radius: 6, x: 0, y: 2)
    }
    
    private func obligationsCard(_ obligacionesPendientes: [ObligacionesPendientesModel]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Obligaciones pendientes")
                .font(.title3.weight(.semibold))
                .foregroundStyle(SRIColors.textPrimary)
            
            LazyVStack(spacing: 0) {
                ForEach(obligacionesPendientes) { obligacionPendiente in
                    ObligacionPendienteItemView(
                        obligacionPendiente: obligacionPendiente,
                        onObligacionSeleccionada: { obligacionSeleccionada = $0 }
                    )
                    
                    if obligacionPendiente.id != obligacionesPendientes.last?.id {
                        Divider()
                            .overlay(SRIColors.border.opacity(0.5))
                            .padding(.leading, 40)
                    }
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(SRIColors.border.opacity(0.7), lineWidth: 0.8)
        }
        .shadow(color: .black.opacity(0.03), radius: 6, x: 0, y: 2)
    }
    
    private var footerNote: some View {
        VStack(alignment: .leading, spacing: 8) {
            Divider()
                .overlay(SRIColors.border.opacity(0.5))
            
            Text("El tiempo reflejado en el Plazo de Vigencia de los Documentos corresponde al tiempo que tendrán vigencia los documentos impresos en el día de hoy.")
                .font(.caption)
                .foregroundStyle(SRIColors.textSecondary)
        }
        .padding(.horizontal, 4)
    }
}

// MARK: - DetailRow

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(label)
                .font(.headline)
                .foregroundStyle(SRIColors.textPrimary)
                .frame(width: 150, alignment: .leading)
            
            Spacer(minLength: 8)
            
            Text(value)
                .font(.body)
                .foregroundStyle(SRIColors.textPrimary)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

// MARK: - ObligacionPendienteItemView

private extension EstadoTributarioDetalleView {
    struct ObligacionPendienteItemView: View {
        let obligacionPendiente: ObligacionesPendientesModel
        let onObligacionSeleccionada: (ObligacionesPendientesModel) -> Void
        
        var body: some View {
            Button {
                onObligacionSeleccionada(obligacionPendiente)
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "doc.text")
                        .foregroundStyle(SRIColors.primary)
                    
                    Text(obligacionPendiente.descripcion)
                        .font(.body)
                        .foregroundStyle(SRIColors.textPrimary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(SRIColors.textSecondary)
                }
                .padding(.vertical, 12)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
}

// MARK: - DetalleObligacionSheetView

private extension EstadoTributarioDetalleView {
    struct DetalleObligacionSheetView: View {
        let obligacionPendiente: ObligacionesPendientesModel
        let cerrarSheet: () -> Void
        
        var body: some View {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        obligationSection
                        periodsSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 32)
                }
                .background(SRIColors.background)
                .navigationTitle("Detalle")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Cerrar") {
                            cerrarSheet()
                        }
                        .foregroundStyle(SRIColors.primary)
                    }
                }
            }
        }
        
        private var obligationSection: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("Obligación")
                    .font(.headline)
                    .foregroundStyle(SRIColors.textPrimary)
                
                Text(obligacionPendiente.descripcion)
                    .font(.body)
                    .foregroundStyle(SRIColors.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(SRIColors.border.opacity(0.7), lineWidth: 0.8)
                    }
            }
        }
        
        private var periodsSection: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("Periodos")
                    .font(.headline)
                    .foregroundStyle(SRIColors.textPrimary)
                
                if obligacionPendiente.periodos.isEmpty {
                    Text("No hay periodos asociados")
                        .font(.subheadline)
                        .foregroundStyle(SRIColors.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(SRIColors.border.opacity(0.7), lineWidth: 0.8)
                        }
                } else {
                    VStack(spacing: 0) {
                        ForEach(Array(obligacionPendiente.periodos.enumerated()), id: \.offset) { index, periodo in
                            Text(periodo)
                                .font(.body)
                                .foregroundStyle(SRIColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 14)
                                .padding(.horizontal, 16)
                            
                            if index < obligacionPendiente.periodos.count - 1 {
                                Divider()
                                    .overlay(SRIColors.border.opacity(0.5))
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(SRIColors.border.opacity(0.7), lineWidth: 0.8)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    let obligacionesPendientes: [ObligacionesPendientesModel] = [
        ObligacionesPendientesModel(
            descripcion: "CONTRIBUYENTE MANTIENE DEUDAS FIRMES",
            periodos: []
        ),
        ObligacionesPendientesModel(
            descripcion: "1024 IMPUESTO A LA RENTA REGIMEN IMPOSITIVO PARA MICROEMPRESAS",
            periodos: ["SEGUNDO SEMESTRE 2020", "PRIMER SEMESTRE 2021", "SEGUNDO SEMESTRE 2021"]
        ),
        ObligacionesPendientesModel(
            descripcion: "DECLARACIÓN DE IMPUESTO A LA RENTA",
            periodos: ["AÑO 2023"]
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
    
    ScrollView {
        EstadoTributarioDetalleView(infoEstadoTributario: estadoTributario)
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
    }
    .background(SRIColors.background)
}



