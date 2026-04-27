//
//  ServicioDestinationBuilder.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 20/4/26.
//

import SwiftUI

@MainActor
struct ServicioDestinationBuilder {
    
    @ViewBuilder
    static func build(for destino: ServicioDestino) -> some View {
        switch destino {
        case .comprobantes:
            LoginView()
        case .estadoTributario:
            EstadoTributarioView()
        case .valoresPagar:
            MatriculacionVehicularView()
        case .deudas:
            DeudasView()
        case .validezDocumentos:
            ValidacionDocumentosView()
        case .seguimientoTramites:
            SeguimientoTramitesView()
        case .validacionQR:
            ValidacionQRView()
        case .calculadoras:
            CalculadorasView()
        case .denuncias:
            DenunciasView()
        case .contactenos:
            ContactenosView()
        case .simar:
            SimarView()
        case .impuestoRenta,
                .certificados,
                .citaPrevia,
                .facturadorSRI:
            EmptyView()
        }
    }
}
