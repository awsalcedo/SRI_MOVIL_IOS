//
//  DeudasDetailView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 02/4/26.
//

import SwiftUI

struct DeudasDetailView: View {
    
    // MARK: - Properties
    
    let deudas: DeudasModel
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                contributorCard
                obligationsSection
                notesSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 32)
        }
        .background(SRIColors.background.ignoresSafeArea())
        .navigationTitle("Deudas")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.regularMaterial, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    // MARK: - Sections
    
    private var contributorCard: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                Text(contributorDisplayName)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(SRIColors.textPrimary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(deudas.contribuyente.identificacion)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(SRIColors.primary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(
                        Capsule(style: .continuous)
                            .fill(SRIColors.primary.opacity(0.16))
                    )
            }
            
            Spacer(minLength: 12)
            
            ZStack {
                Circle()
                    .fill(SRIColors.primary.opacity(0.10))
                    .frame(width: 56, height: 56)
                
                Image(systemName: contributorIconName)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(SRIColors.primary)
            }
            .accessibilityHidden(true)
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(SRIColors.cardBackground)
                .overlay {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(SRIColors.border.opacity(0.28), lineWidth: 1)
                }
        )
    }
    
    private var obligationsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("Estado de obligaciones")
            
            VStack(spacing: 0) {
                obligationRow(
                    title: "Fecha de corte",
                    value: formattedCutoffDate,
                    systemImage: "calendar"
                )
                
                divider
                
                obligationRow(
                    title: "Deudas firmes",
                    value: debtStatusText,
                    systemImage: "wallet.pass",
                    highlightValue: hasDebt
                )
                
                divider
                
                obligationRow(
                    title: "Impugnaciones",
                    value: impugnacionStatusText,
                    systemImage: "exclamationmark.bubble",
                    highlightValue: hasImpugnaciones
                )
                
                if deudas.remision != nil {
                    divider
                    
                    obligationRow(
                        title: "Remisión",
                        value: remisionStatusText,
                        systemImage: "checkmark.seal",
                        highlightValue: hasRemision
                    )
                }
            }
            .background(cardBackground)
        }
    }
    
    private var notesSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("Información importante")
            
            VStack(alignment: .leading, spacing: 16) {
                noteItem("La información registrada puede variar si existió un pago o justificación de obligaciones pendientes en los últimos días.")
                
                noteItem("En caso de existir inconsistencias en la información de su deuda, acérquese a la oficina del SRI más cercana.")
                
                noteItem("Impugnaciones son los actos que pretenden obtener la modificación, revocatoria o invalidación de un acto administrativo. Se tramitan ante la propia Administración Tributaria o los Tribunales de la República.")
            }
            .padding(20)
            .background(cardBackground)
        }
    }
    
    // MARK: - Components
    
    private func sectionTitle(_ text: String) -> some View {
        Text(text.uppercased())
            .font(.caption.weight(.semibold))
            .tracking(0.8)
            .foregroundStyle(SRIColors.textSecondary)
    }
    
    private func obligationRow(
        title: String,
        value: String,
        systemImage: String,
        highlightValue: Bool = false
    ) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(SRIColors.primary.opacity(0.08))
                    .frame(width: 44, height: 44)

                Image(systemName: systemImage)
                    .font(.headline)
                    .foregroundStyle(SRIColors.textPrimary)
            }

            Text(title)
                .font(.body.weight(.semibold))
                .foregroundStyle(SRIColors.textPrimary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .layoutPriority(1)

            Spacer(minLength: 12)

            Text(value)
                .font(.body.weight(highlightValue ? .semibold : .regular))
                .foregroundStyle(highlightValue ? SRIColors.primary : SRIColors.textPrimary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 18)
    }
    
    private func noteItem(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Text("•")
                .font(.body.weight(.bold))
                .foregroundStyle(SRIColors.textSecondary)
            
            Text(text)
                .font(.body)
                .foregroundStyle(SRIColors.textSecondary)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private var divider: some View {
        Divider()
            .overlay(SRIColors.border.opacity(0.55))
            .padding(.leading, 74)
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(SRIColors.cardBackground)
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(SRIColors.border.opacity(0.32), lineWidth: 1)
            }
    }
    
    // MARK: - Computed Helpers
    
    private var contributorDisplayName: String {
        if let denominacion = deudas.contribuyente.denominacion,
           !denominacion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return denominacion
        }
        
        return deudas.contribuyente.nombreComercial
    }
    
    private var contributorIconName: String {
        switch deudas.contribuyente.tipoIdentificacion {
        case "R":
            return "building.2"
        default:
            return "person"
        }
    }
    
    private var formattedCutoffDate: String {
        guard let fecha = deudas.contribuyente.fechaInformacion else {
            return "No disponible"
        }
        
        return fecha.formatted(
            .dateTime
                .day(.twoDigits)
                .month(.twoDigits)
                .year()
        )
    }
    
    private var hasDebt: Bool {
        guard let deuda = deudas.deuda else { return false }
        return deuda.valor > 0
    }
    
    private var debtStatusText: String {
        guard let deuda = deudas.deuda else {
            return "No registra deudas firmes"
        }
        
        if deuda.valor > 0 {
            return formattedCurrency(deuda.valor)
        }
        
        return "No registra deudas firmes"
    }
    
    private var hasImpugnaciones: Bool {
        guard let impugnacion = deudas.impugnacion else { return false }
        return !impugnacion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var impugnacionStatusText: String {
        if let impugnacion = deudas.impugnacion,
           !impugnacion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return impugnacion
        }
        
        return "No registra impugnaciones"
    }
    
    private var hasRemision: Bool {
        guard let remision = deudas.remision else { return false }
        return !remision.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var remisionStatusText: String {
        if let remision = deudas.remision,
           !remision.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return remision
        }
        
        return "No registra remisión"
    }
    
    private func formattedCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.locale = Locale(identifier: "es_EC")
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}

#Preview {
    NavigationStack {
        DeudasDetailView(
            deudas: DeudasModel(
                contribuyente: ContribuyenteModel(
                    identificacion: "1712245974001",
                    denominacion: nil,
                    tipo: nil,
                    clase: "NO REGISTRADO",
                    tipoIdentificacion: "R",
                    resolucion: nil,
                    nombreComercial: "SALCEDO SILVA ALEX WLADIMIR",
                    direccionMatriz: nil,
                    fechaInformacion: Date(),
                    mensaje: nil,
                    estado: nil
                ),
                deuda: nil,
                impugnacion: nil,
                remision: nil
            )
        )
    }
}
