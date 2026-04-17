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
            imagenServicio: "matriculacion_vehicular_boton",
            categoria: .vehiculos,
            destino: .valoresPagar,
            esDestacado: true
        ),
        Servicio(
            nombreServicio: "Estado Tributario",
            imagenServicio: "estado_tributario_boton",
            categoria: .tributario,
            destino: .estadoTributario,
            esDestacado: true
        ),
        Servicio(
            nombreServicio: "Deudas",
            imagenServicio: "deudas_boton",
            categoria: .tributario,
            destino: .deudas,
            esDestacado: true
        ),
        Servicio(
            nombreServicio: "Comprobantes Electrónicos",
            imagenServicio: "comprobantes_electronicos_boton",
            categoria: .documentos,
            destino: .comprobantes
        ),
        Servicio(
            nombreServicio: "Validez de Documentos",
            imagenServicio: "validez_documentos_boton",
            categoria: .documentos,
            destino: .validezDocumentos
        ),
        Servicio(
            nombreServicio: "Impuesto a la Renta",
            imagenServicio: "impuesto_renta_boton",
            categoria: .tributario,
            destino: .impuestoRenta
        ),
        Servicio(
            nombreServicio: "Certificados",
            imagenServicio: "certificados_boton",
            categoria: .documentos,
            destino: .certificados
        ),
        Servicio(
            nombreServicio: "Seguimiento de Trámites",
            imagenServicio: "seguimiento_tramites_boton",
            categoria: .tramites,
            destino: .seguimientoTramites
        ),
        Servicio(
            nombreServicio: "Validación QR",
            imagenServicio: "validacion_qr_boton",
            categoria: .tramites,
            destino: .validacionQR
        ),
        Servicio(
            nombreServicio: "Cita Previa",
            imagenServicio: "cita_previa_boton",
            categoria: .tramites,
            destino: .citaPrevia
        ),
        Servicio(
            nombreServicio: "Calculadoras",
            imagenServicio: "calculadoras_boton",
            categoria: .herramientas,
            destino: .calculadoras
        ),
        Servicio(
            nombreServicio: "Denuncias",
            imagenServicio: "denuncias_boton",
            categoria: .soporte,
            destino: .denuncias
        ),
        Servicio(
            nombreServicio: "Contáctenos",
            imagenServicio: "contactenos_boton",
            categoria: .soporte,
            destino: .contactenos
        ),
        Servicio(
            nombreServicio: "SIMAR",
            imagenServicio: "simar_boton",
            categoria: .herramientas,
            destino: .simar
        ),
        Servicio(
            nombreServicio: "Facturador SRI",
            imagenServicio: "facturador_sri_boton",
            categoria: .herramientas,
            destino: .facturadorSRI
        )
    ]
}
