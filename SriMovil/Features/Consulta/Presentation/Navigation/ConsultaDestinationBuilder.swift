//
//  ConsultaDestinationBuilder.swift
//  SriMovil
//
//  Created by usradmin on 5/6/26.
//

import SwiftUI

/// Construye las pantallas destino asociadas a las rutas de consultas.
///
/// Centralizar este builder evita llenar `ConsultasLegadaView` con lógica
/// de construcción de vistas y mantiene la navegación más ordenada.
enum ConsultaDestinationBuilder {
    
    @ViewBuilder
    static func build(for route: ConsultaRoute) -> some View {
        switch route {
        case .comprobantesElectronicos:
            ComprobantesElectronicosView(
                razonSocial: "",
                onOpenAccount: { }
            )
            
        case .estadoTributario:
            EstadoTributarioView()
            
        case .valoresPagar:
            MatriculacionVehicularView()
            
        case .deudas:
            DeudasView()
            
        case .validezComprobantes:
            ValidacionDocumentosView()
            
        case .impuestoRenta:
            ImpuestoRentaView()
            
        case .certificados:
            CertificadosView()
            
        case .seguimientoTramites:
            SeguimientoTramitesView()
            
        case .validacionQR:
            ValidacionQRView()
            
        case .citaPrevia:
            CitaPreviaView()
            
        case .calculadoras:
            CalculadorasView()
            
        case .denuncias:
            DenunciasView()
            
        case .contactenos:
            ContactenosView()
            
        case .simar:
            SimarView()
            
        case .facturadorSRI:
            FacturadorSRIView()
            
        case .configuracion:
            ConfiguracionView()
            
        case .politicaDatos:
            PoliticaProteccionDatosView()
        }
    }
}
