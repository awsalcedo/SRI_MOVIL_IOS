//
//  RubrosView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct RubrosView: View {
    let rubros: [Rubro]
    
    var body: some View {
        NavigationStack {
            List(rubros) { rubro in
                NavigationLink {
                    DetalleRubrosView(detalleRubros: rubro.detallesRubro)
                } label: {
                    VStack(alignment: .leading) {
                        Text(rubro.descripcion)
                            .font(.subheadline)
                            .bold()
                        Text("Valor: \(FormatterUtils.formattedCurrency(value: rubro.valor))")
                            .font(.footnote)
                        Text(rubro.periodoFiscal)
                            .font(.footnote)
                        Text(rubro.beneficiario)
                            .font(.footnote)
                    }
                }
                
            }
            .padding(.vertical, 20)
            .navigationTitle("Rubros")
            .toolbarTitleDisplayMode(.inline)
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
        
        
        let rubros = [Rubro(from: rubrosDto)]
        
        RubrosView(rubros: rubros)
    }
}
