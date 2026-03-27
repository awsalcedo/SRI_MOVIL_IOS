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


struct Servicio: Identifiable {
    let id: UUID
    let nombreServicio: String
    let imagenServicio: String?
    let vista: ServicioViewType
}

let servicios: [Servicio] = [
    /*Servicio(nombreServicio: "Comprobantes electrónicos", imagenServicio: "comprobantes", vista: .comprobantes),*/
    Servicio(id: UUID(), nombreServicio: "Comprobantes electrónicos", imagenServicio: "comprobantes_electronicos_boton", vista: .comprobantes),
    Servicio(id: UUID(), nombreServicio: "Estado tributario", imagenServicio: "estado_tributario_boton", vista: .estadoTributario),
    Servicio(id: UUID(), nombreServicio: "Valores a pagar", imagenServicio: "matriculacion_boton", vista: .valoresPagar),
    Servicio(id: UUID(), nombreServicio: "Deudas", imagenServicio: "pagos_boton", vista: .deudas),
    Servicio(id: UUID(), nombreServicio: "Validez documentos físicos", imagenServicio: "documentos_boton", vista: .validezDocumentos),
    Servicio(id: UUID(), nombreServicio: "Impuesto a la Renta Causado", imagenServicio: "impuesto_boton", vista: .impuestoRenta),
    Servicio(id: UUID(), nombreServicio: "Certificados", imagenServicio: "certificados_boton", vista: .certificados),
    Servicio(id: UUID(), nombreServicio: "Seguimiento de trámites", imagenServicio: "tramites_boton", vista: .seguimientoTramites),
    Servicio(id: UUID(), nombreServicio: "Validación códigos QR", imagenServicio: "validacion_qr_boton", vista: .validacionQR),
    Servicio(id: UUID(), nombreServicio: "Cita previa", imagenServicio: "turnos_movil_boton", vista: .citaPrevia),
    Servicio(id: UUID(), nombreServicio: "Calculadoras", imagenServicio: "calculadora_boton", vista: .calculadoras),
    Servicio(id: UUID(), nombreServicio: "Denuncias", imagenServicio: "denuncias_50_boton", vista: .denuncias),
    Servicio(id: UUID(), nombreServicio: "Contáctenos", imagenServicio: "contacto_50_boton", vista: .contactenos),
    Servicio(id: UUID(), nombreServicio: "SIMAR", imagenServicio: "simar_boton", vista: .simar),
    Servicio(id: UUID(), nombreServicio: "Facturador SRI", imagenServicio: "facturador_boton", vista: .facturadorSRI),
    Servicio(id: UUID(), nombreServicio: "Configuración", imagenServicio: "configuracion_boton", vista: .configuracion),
    Servicio(id: UUID(), nombreServicio: "Política Protección de Datos", imagenServicio: "politica_boton", vista: .politicaProteccionDatos)
]
