//
//  DetalleMatriculacionView.swift
//  SriMovil
//
//  Created by usradmin on 6/8/24.
//

import SwiftUI

struct DetalleMatriculacionView: View {
    let infoVehiculo: InfoVehiculoModel
    
    var body: some View {
        NavigationStack {
            
            CabeceraDetalleMatriculacionView(infoVehiculo: infoVehiculo)
            
            DetalleVehiculoView(infoVehiculo: infoVehiculo)
            
        }
    }
}

struct CabeceraDetalleMatriculacionView: View {
    let infoVehiculo: InfoVehiculoModel
    var body: some View {
        if infoVehiculo.tasas != nil {
            ValoresPagarView(infoVehiculo: infoVehiculo)
            
        } else {
            NoExistenValoresPagarView()
        }
    }
}

struct DetalleVehiculoView: View {
    let infoVehiculo: InfoVehiculoModel
    var body: some View {
        List {
            
            Section(header: Text("Detalle del Vehículo")
                .font(.subheadline)
                .bold()
                .foregroundColor(.primary)
                .padding(.bottom, 5)) {
                    DetalleRow(iconName: "car.fill", label: "Placa", value: infoVehiculo.placa)
                    DetalleRow(iconName: "number", label: "RAMV o CPM", value: infoVehiculo.camvCpn)
                    DetalleRow(iconName: "tag.fill", label: "Marca", value: infoVehiculo.marca)
                    DetalleRow(iconName: "doc.text.fill", label: "Modelo", value: infoVehiculo.modelo)
                    DetalleRow(iconName: "calendar", label: "Año", value: String(infoVehiculo.anioModelo))
                    DetalleRow(iconName: "flag.fill", label: "País", value: infoVehiculo.paisFabricacion)
                    DetalleRow(iconName: "clock.fill", label: "Último pago", value: String(infoVehiculo.anioUltimoPago))
                }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Detalle Vehículo")
        .toolbarBackground(.blue, for: .navigationBar)
        .toolbarTitleDisplayMode(.inline)
    }
}

struct DetalleRow: View {
    let iconName: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.blue)
                .padding()
            VStack(alignment: .leading) {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
        //.padding(.vertical, 5)
    }
}

struct ValoresPagarView: View {
    let infoVehiculo: InfoVehiculoModel
    
    var body: some View {
    
        NavigationLink {
            if let deudas = infoVehiculo.deudas {
                NavigationView {
                    List {
                        ForEach(deudas) { deuda in
                            TipoDeudaItemsView(deuda: deuda)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("Por tipo de deuda")
                    .toolbarBackground(.blue, for: .navigationBar)
                    .toolbarTitleDisplayMode(.inline)
                }
            }
        } label: {
            HStack {
                Text("Valor total a pagar:")
                    .font(.subheadline)
                    .bold()
                    .padding(8)
                Spacer()
                Text(FormatterUtils.formattedCurrency(value: infoVehiculo.total ?? 0.00))
                    .font(.subheadline)
                    .bold()
                    .padding(8)
            }
            .foregroundColor(.white)
            .background(Color.blue)
            .padding()
        }
    }
}

struct TipoDeudaItemsView: View {
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

struct DetalleMatriculacionView_Previews: PreviewProvider {
    static var previews: some View {
        
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
            deudas: nil,
            tasas: nil,
            remision: nil
        )
        
        let infoVehiculoModel = infoVehiculoDto.toDomain
        
        DetalleMatriculacionView(infoVehiculo: infoVehiculoModel)
    }
}
