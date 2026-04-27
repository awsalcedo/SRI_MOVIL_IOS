//
//  ServicioDestacadoCard.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 17/4/26.
//

import SwiftUI

/// Tarjeta visual para presentar un servicio destacado dentro de la pantalla de consultas.
///
/// `ServicioDestacadoCard` representa accesos frecuentes o prioritarios mediante una
/// composición compacta, centrada y fácil de escanear.
///
/// La tarjeta está diseñada para secciones horizontales de contenido destacado, donde
/// cada servicio debe tener suficiente peso visual sin competir con el resto de la
/// pantalla.
///
/// ## Características
/// - Presenta el nombre del servicio en máximo dos líneas.
/// - Usa íconos propios desde Assets cuando están disponibles.
/// - Aplica un SF Symbol de respaldo cuando no existe un asset asociado.
/// - Utiliza un fondo neutro y un contenedor de ícono con color para mantener jerarquía visual.
/// - Mantiene un área táctil definida mediante `contentShape`.
///
/// ## Consideraciones
/// - Los íconos de Assets deberían configurarse como `Template Image` para permitir tintado.
/// - Esta vista no decide si un servicio es destacado; únicamente renderiza el modelo recibido.
/// - La lógica de selección, navegación o autenticación debe permanecer fuera de este componente.
struct ServicioDestacadoCard: View {
    
    // MARK: - Properties
    
    let servicio: Servicio
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 14) {
            icon
            
            Text(servicio.nombreServicio)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.88)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 18)
        .frame(width: 154, height: 128)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color(.separator).opacity(0.18), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.035), radius: 8, x: 0, y: 4)
        .contentShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
    
    // MARK: - Subviews
        
    /// Contenedor visual del ícono del servicio.
    private var icon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(tintColor.gradient)
                .frame(width: 52, height: 52)
            
            iconImage
                .frame(width: 24, height: 24)
        }
        .shadow(color: tintColor.opacity(0.22), radius: 8, x: 0, y: 4)
    }
    
    /// Imagen del ícono asociado al servicio.
    ///
    /// Prioriza íconos definidos en Assets para servicios frecuentes del dominio.
    /// Si no existe un asset asociado, usa un SF Symbol genérico como respaldo.
    @ViewBuilder
    private var iconImage: some View {
        if let assetName = assetIconName {
            Image(assetName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white) // si es template
        } else {
            Image(systemName: "square.grid.2x2.fill")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
        }
    }
    
    // MARK: - Styling
        
    /// Color principal utilizado para el fondo del ícono.
    private var tintColor: Color {
        switch servicio.destino {
        case .valoresPagar:
            return .blue
        case .estadoTributario:
            return .orange
        case .deudas:
            return .indigo
        case .comprobantes:
            return .teal
        default:
            return SRIColors.primary
        }
    }
    
    /// Nombre del asset asociado al destino del servicio.
    ///
    /// Retorna `nil` cuando no existe un ícono específico, permitiendo usar
    /// el SF Symbol de respaldo definido en `iconImage`.
    private var assetIconName: String? {
        switch servicio.destino {
        case .comprobantes:
            return "comprobantes"
        case .estadoTributario:
            return "estado_tributario"
        case .valoresPagar:
            return "matriculacion"
        case .deudas:
            return "pagos"
        default:
            return nil
        }
    }
}

#Preview {
    ServicioDestacadoCard(
        servicio: Servicio(
            nombreServicio: "Estado Tributario",
            imagenServicio: nil,
            categoria: .tributario,
            destino: .estadoTributario,
            esDestacado: true
        )
    )
    .padding()
    .background(SRIColors.background)
}

#Preview("Sin icono (fallback SF Symbol)") {
    ServicioDestacadoCard(
        servicio: Servicio(
            nombreServicio: "Calculadoras",
            imagenServicio: nil,
            categoria: .herramientas,
            destino: .calculadoras,
            esDestacado: true
        )
    )
    .padding()
    .background(SRIColors.background)
}
