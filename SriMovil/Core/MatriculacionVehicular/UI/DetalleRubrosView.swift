//
//  DetalleRubrosView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct DetalleRubrosView: View {
    let detalleRubros: [DetallesRubro]
    
    var body: some View {
        
        NavigationStack {
            List(detalleRubros) { detalleRubro in
                HStack {
                    VStack(alignment: .leading) {
                        Text(detalleRubro.descripcion)
                            .font(.footnote)
                            .bold()
                        Text(String(detalleRubro.anio))
                            .font(.footnote)
                    }
                    Spacer()
                    
                    Text(FormatterUtils.formattedCurrency(value: detalleRubro.valor))
                        .font(.footnote)
                }
            }
            .padding(.vertical, 20)
            .navigationTitle("Detalle rubros")
            .toolbarTitleDisplayMode(.inline)
        }
        
    }
}

struct DetalleRubrosView_Previews: PreviewProvider {
    static var previews: some View {
        // Crear datos de ejemplo para la vista previa
        /*let detallesRubroDto = [
         DetallesRubroDto(descripcion: "AJU_IMPUESTO", anio: 2022, valor: 535.7),
         DetallesRubroDto(descripcion: "INT_AJU_IMPUESTO", anio: 2022, valor: 104.87),
         DetallesRubroDto(descripcion: "REMISION_SRI_2023", anio: 2022, valor: -104.87),
         DetallesRubroDto(descripcion: "AJU_IMPUESTO", anio: 2021, valor: 965.12),
         DetallesRubroDto(descripcion: "INT_AJU_IMPUESTO", anio: 2021, valor: 283.79),
         DetallesRubroDto(descripcion: "REMISION_SRI_2023", anio: 2021, valor: -283.79),
         DetallesRubroDto(descripcion: "AJU_IMPUESTO", anio: 2020, valor: 1411.4),
         DetallesRubroDto(descripcion: "INT_AJU_IMPUESTO", anio: 2020, valor: 444.65),
         DetallesRubroDto(descripcion: "REMISION_SRI_2023", anio: 2020, valor: -444.65)
         ]*/
        
        let detalleRubro = DetallesRubroDto(descripcion: "AJU_IMPUESTO", anio: 2022, valor: 535.7)
        
        let detallesRubros = [DetallesRubro(from: detalleRubro)]
        
        DetalleRubrosView(detalleRubros: detallesRubros)
    }
}
