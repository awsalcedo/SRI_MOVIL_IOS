//
//  Servicio.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI
import Foundation

enum ServicioViewType {
    case comprobantes
    case estadoTributario
    case valoresPagar
    case deudas
    case validezDocumentos
    case impuestoRenta
    case certificados
    case seguimientoTramites
    case validacionQR
    case citaPrevia
    case calculadoras
    case denuncias
    case contactenos
    case simar
    case facturadorSRI
    case configuracion
    case politicaProteccionDatos
}


struct Servicio {
    let nombreServicio: String
    let imagenServicio: String?
    let vista: ServicioViewType
}

let servicios: [Servicio] = [
    Servicio(nombreServicio: "Comprobantes electrónicos", imagenServicio: "comprobantes", vista: .comprobantes),
    Servicio(nombreServicio: "Estado tributario", imagenServicio: "estado_tributario", vista: .estadoTributario),
    Servicio(nombreServicio: "Valores a pagar", imagenServicio: "matriculacion", vista: .valoresPagar),
    Servicio(nombreServicio: "Deudas", imagenServicio: "pagos", vista: .deudas),
    Servicio(nombreServicio: "Validez documentos físicos", imagenServicio: "documentos", vista: .validezDocumentos),
    Servicio(nombreServicio: "Impuesto a la Renta Causado", imagenServicio: "impuesto", vista: .impuestoRenta),
    Servicio(nombreServicio: "Certificados", imagenServicio: "certificados", vista: .certificados),
    Servicio(nombreServicio: "Seguimiento de trámites", imagenServicio: "tramites", vista: .seguimientoTramites),
    Servicio(nombreServicio: "Validación códigos QR", imagenServicio: "validacion_qr", vista: .validacionQR),
    Servicio(nombreServicio: "Cita previa", imagenServicio: "turnos_movil", vista: .citaPrevia),
    Servicio(nombreServicio: "Calculadoras", imagenServicio: "calculadora", vista: .calculadoras),
    Servicio(nombreServicio: "Denuncias", imagenServicio: "denuncias_50", vista: .denuncias),
    Servicio(nombreServicio: "Contáctenos", imagenServicio: "contacto_50", vista: .contactenos),
    Servicio(nombreServicio: "SIMAR", imagenServicio: "simar", vista: .simar),
    Servicio(nombreServicio: "Facturador SRI", imagenServicio: "facturador", vista: .facturadorSRI),
    Servicio(nombreServicio: "Configuración", imagenServicio: "configuracion", vista: .configuracion),
    Servicio(nombreServicio: "Política Protección de Datos", imagenServicio: nil, vista: .politicaProteccionDatos)
]
