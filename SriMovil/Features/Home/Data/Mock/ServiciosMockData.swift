//
//  ServiciosMockData.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import Foundation

enum ServiciosMockData {
    static let items: [Servicio] = [
        Servicio(
            nombreServicio: "Matriculación Vehicular",
            imagenServicio: "matriculacion",
            categoria: .vehiculos,
            destino: .valoresPagar,
            esDestacado: true
        ),
        Servicio(
            nombreServicio: "Estado Tributario",
            imagenServicio: "estado_tributario",
            categoria: .tributario,
            destino: .estadoTributario,
            esDestacado: true
        ),
        Servicio(
            nombreServicio: "Deudas",
            imagenServicio: "pagos",
            categoria: .tributario,
            destino: .deudas,
            esDestacado: true
        ),
        Servicio(
            nombreServicio: "Comprobantes Electrónicos",
            imagenServicio: "comprobantes",
            categoria: .documentos,
            destino: .comprobantes
        ),
        Servicio(
            nombreServicio: "Validez de Documentos",
            imagenServicio: "documentos",
            categoria: .documentos,
            destino: .validezDocumentos
        ),
        Servicio(
            nombreServicio: "Impuesto a la Renta",
            imagenServicio: "impuesto",
            categoria: .tributario,
            destino: .impuestoRenta
        ),
        Servicio(
            nombreServicio: "Certificados",
            imagenServicio: "certificados",
            categoria: .documentos,
            destino: .certificados
        ),
        Servicio(
            nombreServicio: "Seguimiento de Trámites",
            imagenServicio: "tramites",
            categoria: .tramites,
            destino: .seguimientoTramites
        ),
        Servicio(
            nombreServicio: "Validación QR",
            imagenServicio: "validacion_qr",
            categoria: .tramites,
            destino: .validacionQR
        ),
        Servicio(
            nombreServicio: "Cita Previa",
            imagenServicio: "turnos_movil",
            categoria: .tramites,
            destino: .citaPrevia
        ),
        Servicio(
            nombreServicio: "Calculadoras",
            imagenServicio: "calculadora",
            categoria: .herramientas,
            destino: .calculadoras
        ),
        Servicio(
            nombreServicio: "Denuncias",
            imagenServicio: "denuncias_50",
            categoria: .soporte,
            destino: .denuncias
        ),
        Servicio(
            nombreServicio: "Contáctenos",
            imagenServicio: "contacto_50",
            categoria: .soporte,
            destino: .contactenos
        ),
        Servicio(
            nombreServicio: "SIMAR",
            imagenServicio: "simar",
            categoria: .herramientas,
            destino: .simar
        ),
        Servicio(
            nombreServicio: "Facturador SRI",
            imagenServicio: "facturador",
            categoria: .herramientas,
            destino: .facturadorSRI
        )
    ]
}
