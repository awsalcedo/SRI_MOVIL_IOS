//
//  RubrosView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct RubrosView: View {
    let rubros: [Rubro]
    // Permite que la vista se actualice su estado correctamente y se reactive cuando cambie su valor
    @State private var rubroSeleccionado: Rubro?
    
    var body: some View {
        NavigationStack {
            List(rubros) { rubro in
                Button(action: {
                    rubroSeleccionado = rubro // Establecer el rubro seleccionado
                }) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(rubro.descripcion)
                                .font(.caption)
                                .bold()
                            Spacer()
                            Text((FormatterUtils.formattedCurrency(value: rubro.valor)))
                                .font(.caption)
                        }
                        
                        Text(rubro.periodoFiscal)
                            .font(.caption2)
                        Text(rubro.beneficiario)
                            .font(.caption2)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Rubros")
            .toolbarBackground(.blue, for: .navigationBar)
            .toolbarTitleDisplayMode(.inline)
            .sheet(item: $rubroSeleccionado) { rubroSeleccionado in
                DetalleRubrosView(detalleRubros: rubroSeleccionado.detallesRubro) {
                    //El uso de self asegura que acceda a la variable @State de la vista
                    // Cierra el sheet
                    self.rubroSeleccionado = nil
                }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
        }
    }
}



struct RubrosView_Previews: PreviewProvider {
    static var previews: some View {
        // Crear datos de ejemplo para la vista previa
        let detallesRubroDto = [
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
        
        let rubrosDto =
        RubroDto(descripcion: "IMPUESTO A LA PROPIEDAD", valor: 2912.22, periodoFiscal: "2020 - 2022", beneficiario: "SRI", detallesRubro: detallesRubroDto)
        
        
        let rubrosModel = [rubrosDto.toDomain]
        
        RubrosView(rubros: rubrosModel)
    }
}
