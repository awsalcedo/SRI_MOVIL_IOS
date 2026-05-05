//
//  ServiciosExternosGroupedList.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 27/4/26.
//

import SwiftUI

/// Lista agrupada para servicios que se abren fuera de la app.
///
/// Este componente presenta accesos a servicios web del SRI con una apariencia
/// cercana a las listas agrupadas nativas de iOS. La vista no decide qué
/// servicios son externos; únicamente renderiza la colección recibida desde el
/// ViewModel.
struct ServiciosExternosGroupedList: View {
    
    // MARK: - Properties
    
    let servicios: [Servicio]
    
    @Environment(\.openURL) private var openURL
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(servicios.enumerated()), id: \.element.id) { index, servicio in
                Button {
                    open(servicio)
                } label: {
                    ServicioExternoRow(servicio: servicio)
                }
                .buttonStyle(.plain)
                
                if index < servicios.count - 1 {
                    Divider()
                        .padding(.leading, 56)
                        .padding(.trailing, 20)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(SRIColors.cardBackground)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(SRIColors.border.opacity(0.28), lineWidth: 1)
        }
        .shadow(
            color: .black.opacity(0.035),
            radius: 10,
            x: 0,
            y: 5
        )
    }
    
    // MARK: - Private Methods
    
    private func open(_ servicio: Servicio) {
        guard let url = servicio.destino.webURL else { return }
        openURL(url)
    }
}

/// Fila para representar un servicio web dentro de una lista agrupada.
private struct ServicioExternoRow: View {
    
    // MARK: - Properties
    
    let servicio: Servicio
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 12) {
            icon
            
            Text(servicio.nombreServicio)
                .font(.body.weight(.medium))
                .foregroundStyle(SRIColors.textPrimary)
                .lineLimit(1)
            
            Spacer(minLength: 12)
            
            Image(systemName: "chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var icon: some View {
        if let assetName = servicio.destino.externalAssetIconName {
            Image(assetName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(SRIColors.secondaryIconBlue)
                .frame(width: 24, height: 24)
                .accessibilityHidden(true)
        } else {
            Image(systemName: servicio.destino.listIconName)
                .font(.body.weight(.semibold))
                .foregroundStyle(SRIColors.secondaryIconBlue)
                .frame(width: 28, height: 28)
                .accessibilityHidden(true)
        }
    }
}

#Preview("Servicios Externos - Light") {
    ServiciosExternosGroupedList(servicios: mockServicios)
        .padding()
        .background(SRIColors.background)
}

#Preview("Servicios Externos - Dark") {
    ServiciosExternosGroupedList(servicios: mockServicios)
        .padding()
        .background(Color.black)
        .preferredColorScheme(.dark)
}

// MARK: - Mock Data

private let mockServicios: [Servicio] = [
    Servicio(
        nombreServicio: "Impuesto a la Renta Causado",
        imagenServicio: nil,
        categoria: .tributario,
        destino: .impuestoRenta
    ),
    Servicio(
        nombreServicio: "Certificados",
        imagenServicio: nil,
        categoria: .documentos,
        destino: .certificados
    ),
    Servicio(
        nombreServicio: "Cita Previa",
        imagenServicio: nil,
        categoria: .tramites,
        destino: .citaPrevia
    ),
    Servicio(
        nombreServicio: "Facturador SRI",
        imagenServicio: nil,
        categoria: .herramientas,
        destino: .facturadorSRI
    )
]
