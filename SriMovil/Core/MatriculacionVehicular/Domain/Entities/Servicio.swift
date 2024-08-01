//
//  Servicio.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI
import Foundation

struct Servicio {
    let nombreServicio: String
    let imagenServicio: String?
    let vista: AnyView
}

let servicios: [Servicio] = [
    Servicio(nombreServicio: "Comprobantes electrónicos", imagenServicio: "comprobantes", vista: AnyView(ComprobantesView())),
    Servicio(nombreServicio: "Estado tributario", imagenServicio: "estado_tributario", vista: AnyView(EstadoTributarioView())),
    Servicio(nombreServicio: "Valores a pagar", imagenServicio: "matriculacion", vista: AnyView(MatriculacionVehicularView())),
    Servicio(nombreServicio: "Deudas", imagenServicio: "pagos", vista: AnyView(DeudasView())),
    Servicio(nombreServicio: "Validez documentos físicos", imagenServicio: "documentos", vista: AnyView(ValidacionDocumentosView())),
    Servicio(nombreServicio: "Impuesto a la Renta Causado", imagenServicio: "impuesto", vista: AnyView(ImpuestoRentaView())),
    Servicio(nombreServicio: "Certificados", imagenServicio: "certificados", vista: AnyView(CertificadosView())),
    Servicio(nombreServicio: "Seguimiento de trámites", imagenServicio: "tramites", vista: AnyView(SeguimientoTramitesView())),
    Servicio(nombreServicio: "Validación códigos QR", imagenServicio: "validacion_qr", vista: AnyView(ValidacionQRView())),
    Servicio(nombreServicio: "Cita previa", imagenServicio: "turnos_movil", vista: AnyView(CitaPreviaView())),
    Servicio(nombreServicio: "Calculadoras", imagenServicio: "calculadora", vista: AnyView(CalculadorasView())),
    Servicio(nombreServicio: "Denuncias", imagenServicio: "denuncias_50", vista: AnyView(DenunciasView())),
    Servicio(nombreServicio: "Contáctenos", imagenServicio: "contacto_50", vista: AnyView(ContactenosView())),
    Servicio(nombreServicio: "SIMAR", imagenServicio: "simar", vista: AnyView(SimarView())),
    Servicio(nombreServicio: "Facturador SRI", imagenServicio: "facturador", vista: AnyView(FacturadorSRIView())),
    Servicio(nombreServicio: "Configuración", imagenServicio: "configuracion", vista: AnyView(ConfiguracionView())),
    Servicio(nombreServicio: "Política Protección de Datos", imagenServicio: nil, vista: AnyView(PoliticaProteccionDatosView()))
]
