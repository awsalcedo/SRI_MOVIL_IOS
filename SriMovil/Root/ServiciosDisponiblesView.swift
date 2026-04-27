//
//  ServiciosDisponiblesView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 27/4/26.
//

import SwiftUI

/// Vista que presenta el catálogo completo de servicios nativos disponibles.
///
/// `ServiciosDisponiblesView` muestra los servicios agrupados por categoría,
/// permitiendo que la pantalla principal de consultas mantenga una jerarquía
/// visual más simple y compacta.
///
/// Esta vista sigue una estrategia de revelado progresivo:
/// - La pantalla principal muestra un subconjunto reducido de servicios.
/// - Esta pantalla presenta el listado completo cuando el usuario decide ver más.
///
/// La vista no decide qué servicios son visibles ni cómo se filtran; recibe:
/// - Las categorías a renderizar.
/// - Un proveedor de servicios por categoría.
/// - Un constructor de filas para mantener flexible la navegación.
///
/// ## Uso
///
/// ```swift
/// ServiciosDisponiblesView(
///     categorias: viewModel.categoriasVisibles,
///     serviciosProvider: { categoria in
///         viewModel.servicios(for: categoria)
///     },
///     rowBuilder: { servicio in
///         AnyView(servicioRowDestination(for: servicio))
///     }
/// )
///
struct ServiciosDisponiblesView: View {
    
    // MARK: - Properties
    
    /// Categorías que deben mostrarse en la lista.
    let categorias: [CategoriaServicio]
    
    /// Proveedor que retorna los servicios asociados a una categoría.
    let serviciosProvider: (CategoriaServicio) -> [Servicio]
    
    /// Constructor visual para cada fila de servicio.
    let rowBuilder: (Servicio) -> AnyView
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: SRISpacing.xxLarge) {
                ForEach(categorias) { categoria in
                    let servicios = serviciosProvider(categoria)
                    
                    SectionBlock(title: categoria.titulo) {
                        VStack(spacing: 10) {
                            ForEach(servicios) { servicio in
                                rowBuilder(servicio)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 24)
        }
        .background(SRIColors.background)
        .navigationTitle("Consultas")
        .navigationBarTitleDisplayMode(.large)
        .scrollIndicators(.hidden)
    }
}

#Preview("Servicios disponibles") {
    NavigationStack {
        ServiciosDisponiblesView(
            categorias: ServiciosPreviewData.categoriasNativas,
            serviciosProvider: { categoria in
                ServiciosPreviewData.serviciosNativos.filter { $0.categoria == categoria }
            },
            rowBuilder: { servicio in
                AnyView(
                    ServicioRowCard(servicio: servicio)
                )
            }
        )
    }
}

#Preview("Servicios disponibles - Dark") {
    NavigationStack {
        ServiciosDisponiblesView(
            categorias: ServiciosPreviewData.categoriasNativas,
            serviciosProvider: { categoria in
                ServiciosPreviewData.serviciosNativos.filter { $0.categoria == categoria }
            },
            rowBuilder: { servicio in
                AnyView(
                    ServicioRowCard(servicio: servicio)
                )
            }
        )
    }
    .preferredColorScheme(.dark)
}
