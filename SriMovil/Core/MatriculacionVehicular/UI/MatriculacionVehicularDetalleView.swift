//
//  MatriculacionVehicularDetalleView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct MatriculacionVehicularDetalleView: View {
    let infoVehiculo: InfoVehiculoModel
    
    var body: some View {
        NavigationStack {
            
            VStack {
                CabeceraInfoVehiculoView(infoVehiculo: infoVehiculo)
                
                NavigationLink {
                    DetalleMatriculacionView(infoVehiculo: infoVehiculo)
                } label: {
                    Text("Detalle Vehículo")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                
                
                if infoVehiculo.tasas != nil {
                    ValorPagarView(infoVehiculo: infoVehiculo)
                } else {
                    NoExistenValoresPagarView()
                }
                
                if let deudas = infoVehiculo.deudas {
                    NavigationView {
                        List {
                            Section("Por tipo de deuda") {
                                ForEach(deudas) { deuda in
                                    TipoDeudaItemView(deuda: deuda)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
            
        }
    }
}

struct CabeceraInfoVehiculoView: View {
    let infoVehiculo: InfoVehiculoModel
    
    var body: some View {
        VStack {
            Text(infoVehiculo.placa)
                .font(.title)
                .bold()
            
            HStack {
                Text("\(infoVehiculo.marca),")
                    .font(.subheadline)
                    .bold()
                Text(String(infoVehiculo.anioModelo))
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

struct NoExistenValoresPagarView: View {
    var body: some View {
        Text("No existen valores a pagar")
            .frame(width: 350)
            .foregroundColor(.white)
            .background(Color.blue)
            .bold()
            .padding(10)
    }
}

struct ValorPagarView: View {
    let infoVehiculo: InfoVehiculoModel
    
    var body: some View {
        HStack {
            Text("Valor total a pagar:")
                .font(.title3)
                .bold()
                .padding(8)
            Spacer()
            Text(FormatterUtils.formattedCurrency(value: infoVehiculo.total ?? 0.00))
                .font(.title3)
                .bold()
                .padding(8)
        }
        .foregroundColor(.white)
        .background(Color.blue)
        .padding()
    }
}

struct TipoDeudaItemView: View {
    let deuda: Deuda
    
    var body: some View {
        NavigationLink {
            RubrosView(rubros: deuda.rubros)
        } label: {
            Label(deuda.descripcion, systemImage: "star")
                .font(.footnote)
                .bold()
            
            VStack(alignment: .trailing) {
                Text("Subtotal:")
                    .font(.footnote)
                    .padding(.horizontal)
                
                Text(FormatterUtils.formattedCurrency(value: deuda.subtotal))
                    .font(.footnote)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
    }
}



struct MatriculacionVehicularDetalleView_Previews: PreviewProvider {
    static var previews: some View {
        
        let detallesRubroDto1 = [
            DetallesRubroDto(descripcion: "AJU_IMPUESTO", anio: 2022, valor: 535.7),
            DetallesRubroDto(descripcion: "INT_AJU_IMPUESTO", anio: 2022, valor: 104.87),
            DetallesRubroDto(descripcion: "REMISION_SRI_2023", anio: 2022, valor: -104.87),
            DetallesRubroDto(descripcion: "AJU_IMPUESTO", anio: 2021, valor: 965.12),
            DetallesRubroDto(descripcion: "INT_AJU_IMPUESTO", anio: 2021, valor: 283.79),
            DetallesRubroDto(descripcion: "REMISION_SRI_2023", anio: 2021, valor: -283.79),
            DetallesRubroDto(descripcion: "AJU_IMPUESTO", anio: 2020, valor: 1411.4),
            DetallesRubroDto(descripcion: "INT_AJU_IMPUESTO", anio: 2020, valor: 444.65),
            DetallesRubroDto(descripcion: "REMISION_SRI_2023", anio: 2020, valor: -444.65)
        ]
        
        let detallesRubroDto2 = [
            DetallesRubroDto(descripcion: "TASA", anio: 2024, valor: 26.74)
        ]
        
        let detallesRubroDto3 = [
            DetallesRubroDto(descripcion: "TASA", anio: 2024, valor: 26.74)
        ]
        
        let detallesRubroDto4 = [
            DetallesRubroDto(descripcion: "TASA", anio: 2024, valor: 36)
        ]
        
        let detallesRubroDto5 = [
            DetallesRubroDto(descripcion: "INTERES", anio: 2024, valor: 6.85),
            DetallesRubroDto(descripcion: "TRANSF_DOM", anio: 2024, valor: 200)
        ]
        
        let rubrosDto1 = [
            RubroDto(descripcion: "IMPUESTO A LA PROPIEDAD", valor: 2912.22, periodoFiscal: "2020 - 2022", beneficiario: "SRI", detallesRubro: detallesRubroDto1)
        ]
        
        let rubrosDto2 = [
            RubroDto(descripcion: "TASA SPPAT", valor: 26.74, periodoFiscal: "2024 - 2024", beneficiario: "SPPAT", detallesRubro: detallesRubroDto2),
            RubroDto(descripcion: "IMPUESTO A LA PROPIEDAD", valor: 0, periodoFiscal: "2024 - 2024", beneficiario: "SRI", detallesRubro: detallesRubroDto3),
            RubroDto(descripcion: "TASAS ANT", valor: 36, periodoFiscal: "2024 - 2024", beneficiario: "MUNICIPIO METROPOLITANO DE QUITO", detallesRubro: detallesRubroDto4)
        ]
        
        let rubrosDto3 = [
            RubroDto(descripcion: "1% TRANSFERENCIA DE DOMINIO", valor: 206.85, periodoFiscal: "2024 - 2024", beneficiario: "SRI", detallesRubro: detallesRubroDto5),
        ]
        
        let deudas = [
            DeudaDto(descripcion: "PAGO DE AJUSTES", rubros: rubrosDto1, subtotal: 2912.22),
            DeudaDto(descripcion: "PAGO DEL VALOR DE LA MATRÍCULA", rubros: rubrosDto2 , subtotal: 62.74),
            DeudaDto(descripcion: "PAGO DEL VALOR DE TRANSFERENCIA DE DOMINIO", rubros: rubrosDto3 , subtotal: 206.85)
        ]
        
        
        
        let tasas = [
            TasaDto(descripcion: "NACIONAL", deudas: deudas, subtotal: 2912.22)
        ]
        
        let infoVehiculoDto = InfoVehiculoDto(
            fechaUltimaMatricula: 1687842000000,
            fechaCaducidadMatricula: 1859173200000,
            cantonMatricula: "QUITO",
            fechaRevision: 1687842000000,
            total: 3181.81,
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
            deudas: deudas,
            tasas: tasas,
            remision: nil
        )
        
        let infoVehiculo = InfoVehiculoModel(from: infoVehiculoDto)
        
        MatriculacionVehicularDetalleView(infoVehiculo: infoVehiculo)
    }
}
