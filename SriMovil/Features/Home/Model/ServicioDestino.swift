//
//  ServicioDestino.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import Foundation

enum ServicioDestino: String, Codable, Hashable {
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
}

extension ServicioDestino {
    
    var isExternal: Bool {
        switch self {
        case .impuestoRenta,
                .certificados,
                .citaPrevia,
                .facturadorSRI:
            return true
        default:
            return false
        }
    }
    
    var webURL: URL? {
        switch self {
        case .impuestoRenta:
            return URL(string: "https://srienlinea.sri.gob.ec/sri-en-linea/SriDeclaracionesWeb/ConsultaImpuestoRenta/Consultas/consultaImpuestoRenta")
        case .certificados:
            return URL(string: "https://srienlinea.sri.gob.ec/sri-en-linea/consulta/27")
        case .citaPrevia:
            return URL(string: "https://srienlinea.sri.gob.ec/turnos-internet-web/publico/menu.jsf")
        case .facturadorSRI:
            return URL(string: "https://srienlinea.sri.gob.ec/portal-facturadorsri-internet/pages/inicio.html")
        default:
            return nil
        }
    }
    
    var listIconName: String {
        switch self {
        case .impuestoRenta:
            return "chart.line.uptrend.xyaxis"
        case .certificados:
            return "doc.text"
        case .citaPrevia:
            return "calendar.badge.clock"
        case .facturadorSRI:
            return "receipt"
        default:
            return "safari"
        }
    }
    
    var externalAssetIconName: String? {
        switch self {
        case .impuestoRenta:
            return "impuesto"
        case .certificados:
            return "certificados"
        case .citaPrevia:
            return "turnos_movil"
        case .facturadorSRI:
            return "facturador"
        default:
            return nil
        }
    }
    
    var assetIconName: String? {
        switch self {
        case .comprobantes:
            return "comprobantes"
        case .estadoTributario:
            return "estado_tributario"
        case .valoresPagar:
            return "matriculacion"
        case .deudas:
            return "pagos"
        case .validezDocumentos:
            return "documentos"
        case .seguimientoTramites:
            return "tramites"
        case .validacionQR:
            return "validacion_qr"
        case .calculadoras:
            return "calculadora"
        case .denuncias:
            return "denuncias_50"
        case .contactenos:
            return "contacto_50"
        case .simar:
            return "simar"
        case .impuestoRenta,
                .certificados,
                .citaPrevia,
                .facturadorSRI:
            return externalAssetIconName
        }
    }
}
