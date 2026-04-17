//
//  MatriculacionPreviewData.swift
//  SriMovil
//
//  Created by usradmin on 17/4/26.
//

import Foundation

enum MatriculacionPreviewData {
    
    // MARK: - Detalles de Rubro
    
    static let detallesRubroImpuesto: [DetallesRubro] = [
        DetallesRubro(descripcion: "AJU_IMPUESTO", anio: 2022, valor: 535.70),
        DetallesRubro(descripcion: "INT_AJU_IMPUESTO", anio: 2022, valor: 104.87),
        DetallesRubro(descripcion: "REMISION", anio: 2022, valor: -104.87)
    ]
    
    static let detallesRubroTasa: [DetallesRubro] = [
        DetallesRubro(descripcion: "TASA", anio: 2024, valor: 26.74)
    ]
    
    static let detallesRubroTransferencia: [DetallesRubro] = [
        DetallesRubro(descripcion: "INTERES", anio: 2024, valor: 6.85),
        DetallesRubro(descripcion: "TRANSF_DOM", anio: 2024, valor: 200.00)
    ]
    
    // MARK: - Rubros
    
    static let rubroImpuesto = Rubro(
        descripcion: "IMPUESTO A LA PROPIEDAD",
        valor: 640.57,
        periodoFiscal: "2022 - 2022",
        beneficiario: "SRI",
        detallesRubro: detallesRubroImpuesto
    )
    
    static let rubroTasa = Rubro(
        descripcion: "TASA SPPAT",
        valor: 26.74,
        periodoFiscal: "2024 - 2024",
        beneficiario: "SPPAT",
        detallesRubro: detallesRubroTasa
    )
    
    static let rubroTransferencia = Rubro(
        descripcion: "1% TRANSFERENCIA DE DOMINIO",
        valor: 206.85,
        periodoFiscal: "2024 - 2024",
        beneficiario: "SRI",
        detallesRubro: detallesRubroTransferencia
    )
    
    // MARK: - Deudas
    
    static let deudaSimple = Deuda(
        descripcion: "PAGO DE AJUSTES",
        rubros: [rubroImpuesto],
        subtotal: 640.57
    )
    
    static let deudaMatricula = Deuda(
        descripcion: "PAGO DEL VALOR DE LA MATRÍCULA",
        rubros: [rubroTasa],
        subtotal: 26.74
    )
    
    static let deudaTransferencia = Deuda(
        descripcion: "PAGO DEL VALOR DE TRANSFERENCIA DE DOMINIO",
        rubros: [rubroTransferencia],
        subtotal: 206.85
    )
    
    static let deudasVarias: [Deuda] = [
        deudaSimple,
        deudaMatricula,
        deudaTransferencia
    ]
    
    static let deudasVacias: [Deuda] = []
    
    // MARK: - Tasas
    
    static let tasas = [
        Tasa(
            descripcion: "NACIONAL",
            deudas: deudasVarias,
            subtotal: deudasVarias.reduce(0) { $0 + $1.subtotal }
        )
    ]
    
    // MARK: - Vehículos
    
    static let vehiculoConDeudas = InfoVehiculoModel(
        fechaUltimaMatricula: 1687842000000,
        fechaCaducidadMatricula: 1859173200000,
        cantonMatricula: "QUITO",
        fechaRevision: 1687842000000,
        total: deudasVarias.reduce(0) { $0 + $1.subtotal },
        informacion: nil,
        estadoAuto: "ASIGNADO",
        mensajeMotivoAuto: nil,
        placa: "PFE8576",
        camvCpn: "U02506654",
        cilindraje: 1987,
        fechaCompra: 1575954000000,
        anioUltimoPago: 2023,
        marca: "TOYOTA",
        modelo: "RAV4 LS AC 2.0 5P 4X2 TM",
        anioModelo: 2020,
        paisFabricacion: "JAPON",
        clase: "JEEP",
        servicio: "PARTICULAR",
        tipoUso: "NO APLICA",
        deudas: deudasVarias,
        tasas: tasas,
        remision: nil
    )
    
    static let vehiculoSinDeudas = InfoVehiculoModel(
        fechaUltimaMatricula: 1687842000000,
        fechaCaducidadMatricula: 1859173200000,
        cantonMatricula: "QUITO",
        fechaRevision: 1687842000000,
        total: 0.0,
        informacion: nil,
        estadoAuto: "AL DIA",
        mensajeMotivoAuto: nil,
        placa: "ABC1234",
        camvCpn: "U00000000",
        cilindraje: 1500,
        fechaCompra: 1575954000000,
        anioUltimoPago: 2024,
        marca: "CHEVROLET",
        modelo: "ONIX",
        anioModelo: 2022,
        paisFabricacion: "BRASIL",
        clase: "AUTOMÓVIL",
        servicio: "PARTICULAR",
        tipoUso: "PRIVADO",
        deudas: nil,
        tasas: nil,
        remision: nil
    )
    
    static let vehiculoConTextosLargos = InfoVehiculoModel(
        fechaUltimaMatricula: 1687842000000,
        fechaCaducidadMatricula: 1859173200000,
        cantonMatricula: "DISTRITO METROPOLITANO DE QUITO",
        fechaRevision: 1687842000000,
        total: 1250.89,
        informacion: nil,
        estadoAuto: "ASIGNADO",
        mensajeMotivoAuto: nil,
        placa: "PFE8576",
        camvCpn: "U02506654-LARGO-DE-EJEMPLO",
        cilindraje: 1987,
        fechaCompra: 1575954000000,
        anioUltimoPago: 2023,
        marca: "TOYOTA",
        modelo: "RAV4 LIMITED AWD HÍBRIDO AC 2.5 5P 4X4 TM CON PAQUETE TECNOLÓGICO EXTENDIDO",
        anioModelo: 2020,
        paisFabricacion: "REPÚBLICA FEDERAL DEMOCRÁTICA DE FABRICACIÓN INTERNACIONAL DE VEHÍCULOS",
        clase: "JEEP UTILITARIO DE USO MIXTO CON CONFIGURACIÓN ESPECIAL",
        servicio: "PARTICULAR DE USO PERSONAL Y ACTIVIDADES COMPLEMENTARIAS",
        tipoUso: "NO APLICA / USO EXTENDIDO / CONFIGURACIÓN ESPECIAL",
        deudas: deudasVarias,
        tasas: tasas,
        remision: nil
    )
    
    // MARK: - Estados de ViewState
    
    static let stateIdle: ViewState<InfoVehiculoModel> = .idle
    
    static let stateLoading: ViewState<InfoVehiculoModel> = .loading
    
    static let stateSuccess: ViewState<InfoVehiculoModel> = .success(vehiculoConDeudas)
    
    static let stateEmptySuccess: ViewState<InfoVehiculoModel> = .success(vehiculoSinDeudas)
    
    static let stateErrorNetwork: ViewState<InfoVehiculoModel> = .failure(
        message: "No se pudo conectar con el servidor",
        isInlineFieldError: false
    )
    
    static let stateErrorInline: ViewState<InfoVehiculoModel> = .failure(
        message: "El identificador ingresado no es válido",
        isInlineFieldError: true
    )
}
