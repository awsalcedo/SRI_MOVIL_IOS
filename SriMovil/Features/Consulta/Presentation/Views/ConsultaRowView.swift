//
//  ConsultaRowView.swift
//  SriMovil
//
//  Created by usradmin on 5/6/26.
//

import SwiftUI

/// Representa una fila de servicio dentro de la pantalla principal
/// de consultas.
///
/// `ConsultaRowView` es una vista presentacional. No conoce reglas de negocio
/// ni navegación; únicamente muestra la información recibida.
struct ConsultaRowView: View {
    
    private enum Layout {
        static let height: CGFloat = 56
        static let iconSize: CGFloat = 34
        static let iconLeadingPadding: CGFloat = 18
        static let iconTrailingPadding: CGFloat = 36
        static let centeredHorizontalPadding: CGFloat = 16
        static let titleFontSize: CGFloat = 17
    }
    
    let item: ConsultaItemModel
    
    var body: some View {
        HStack(spacing: 0) {
            if item.hasIcon {
                Image(item.icon)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundStyle(Color(red: 0.27, green: 0.30, blue: 0.34))
                    .frame(width: Layout.iconSize, height: Layout.iconSize)
                    .padding(.leading, Layout.iconLeadingPadding)
                    .padding(.trailing, Layout.iconTrailingPadding)
            }
            
            Text(item.title)
                .font(.system(size: Layout.titleFontSize, weight: .bold))
                .foregroundStyle(Color(red: 0.25, green: 0.28, blue: 0.32))
                .lineLimit(1)
                .minimumScaleFactor(0.9)
                .multilineTextAlignment(item.isCentered ? .center : .leading)
                .frame(
                    maxWidth: .infinity,
                    alignment: item.isCentered ? .center : .leading
                )
                .padding(.horizontal, item.isCentered ? Layout.centeredHorizontalPadding : 0)
        }
        .frame(height: Layout.height)
        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.gray.opacity(0.28))
                .frame(height: 1)
        }
        .contentShape(Rectangle())
        .accessibilityLabel(item.title)
    }
}

#Preview("Consulta con ícono") {
    ConsultaRowView(
        item: ConsultaItemModel(
            id: "ET001",
            title: "Estado tributario",
            icon: "estado_tributario",
            type: .estadoTributario,
            isCentered: false
        )
    )
    .background(SRIColors.background)
}

#Preview("Consulta centrada sin ícono") {
    ConsultaRowView(
        item: ConsultaItemModel(
            id: "PD001",
            title: "Política Protección de Datos",
            icon: "",
            type: .politicaDatos,
            isCentered: true
        )
    )
    .background(SRIColors.background)
}
