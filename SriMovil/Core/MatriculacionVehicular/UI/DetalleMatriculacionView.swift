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
            List {
                Section(header: Text("Detalle del Vehículo")
                    .font(.headline)
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
                    .font(.body)
                    .foregroundColor(.primary)
            }
        }
        .padding(.vertical, 5)
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
        
        let infoVehiculo = InfoVehiculoModel(from: infoVehiculoDto)
        
        DetalleMatriculacionView(infoVehiculo: infoVehiculo)
    }
}
