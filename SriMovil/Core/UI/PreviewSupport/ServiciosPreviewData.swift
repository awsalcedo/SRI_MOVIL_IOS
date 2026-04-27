//
//  ServiciosPreviewData.swift
//  SriMovil
//

import Foundation

enum ServiciosPreviewData {
    
    static let serviciosExternos: [Servicio] = [
        Servicio(
            nombreServicio: "Impuesto a la Renta Causado",
            imagenServicio: nil,
            categoria: .tributario,
            destino: .impuestoRenta
        ),
        Servicio(
            nombreServicio: "Certificados",
            imagenServicio: nil,
            categoria: .documentos,
            destino: .certificados
        ),
        Servicio(
            nombreServicio: "Cita Previa",
            imagenServicio: nil,
            categoria: .tramites,
            destino: .citaPrevia
        ),
        Servicio(
            nombreServicio: "Facturador SRI",
            imagenServicio: nil,
            categoria: .herramientas,
            destino: .facturadorSRI
        )
    ]
}

extension ServiciosPreviewData {
    
    static let serviciosNativos: [Servicio] = [
        Servicio(
            nombreServicio: "Matriculación Vehicular",
            imagenServicio: nil,
            categoria: .vehiculos,
            destino: .valoresPagar,
            esDestacado: true
        ),
        Servicio(
            nombreServicio: "Estado Tributario",
            imagenServicio: nil,
            categoria: .tributario,
            destino: .estadoTributario,
            esDestacado: true
        ),
        Servicio(
            nombreServicio: "Deudas",
            imagenServicio: nil,
            categoria: .tributario,
            destino: .deudas
        ),
        Servicio(
            nombreServicio: "Comprobantes Electrónicos",
            imagenServicio: nil,
            categoria: .documentos,
            destino: .comprobantes,
            esDestacado: true
        ),
        Servicio(
            nombreServicio: "Validez de Documentos",
            imagenServicio: nil,
            categoria: .documentos,
            destino: .validezDocumentos
        ),
        Servicio(
            nombreServicio: "Seguimiento de Trámites",
            imagenServicio: nil,
            categoria: .tramites,
            destino: .seguimientoTramites
        ),
        Servicio(
            nombreServicio: "Validación QR",
            imagenServicio: nil,
            categoria: .tramites,
            destino: .validacionQR
        ),
        Servicio(
            nombreServicio: "Calculadoras",
            imagenServicio: nil,
            categoria: .herramientas,
            destino: .calculadoras
        ),
        Servicio(
            nombreServicio: "SIMAR",
            imagenServicio: nil,
            categoria: .herramientas,
            destino: .simar
        ),
        Servicio(
            nombreServicio: "Denuncias",
            imagenServicio: nil,
            categoria: .soporte,
            destino: .denuncias
        ),
        Servicio(
            nombreServicio: "Contáctenos",
            imagenServicio: nil,
            categoria: .soporte,
            destino: .contactenos
        )
    ]
    
    static let categoriasNativas: [CategoriaServicio] = CategoriaServicio.ordered.filter { categoria in
        serviciosNativos.contains { $0.categoria == categoria }
    }
}
