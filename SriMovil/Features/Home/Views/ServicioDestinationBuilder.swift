//
//  ServicioDestinationBuilder.swift
//  SriMovil
//
//  Created by usradmin on 20/4/26.
//

import SwiftUI

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
        }
    }
}
