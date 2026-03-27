//
//  DetalleRubrosView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct DetalleRubrosView: View {
    let detalleRubros: [DetallesRubro] // Pasamos los detalles del rubro
    let descripcionRubro: String
    // Closure para cerrar el sheet
    var cerrarSheet: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                // Encabezado con botón "X" para cerrar el sheet
                HStack {
                    Spacer()
                    Text("Detalle de los Rubros")
                        .font(.title3)
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        cerrarSheet()  // Llamar la closure para cerrar el sheet
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 15))
                            //.foregroundColor(.black)
                            .foregroundStyle(.black)
                            .padding(.horizontal, 5)
                    }
                }
                
                Text(descripcionRubro)
                    .font(.caption)
                
                Divider()
                
                if !detalleRubros.isEmpty {
                    List(detalleRubros) { detalle in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(detalle.descripcion)
                                    .font(.subheadline)
                                    .bold()
                                
                                Spacer()
                                
                                Text(FormatterUtils.formattedCurrency(value: detalle.valor))
                                    .font(.footnote)
                            }
                            
                            
                            Text(String(detalle.anio))
                                .font(.footnote)
                            
                        }
                    }
                } else {
                    Text("No hay detalles disponibles")
                        .padding()
                }
            }
            .padding()
        }
        
    }
}



struct DetalleRubrosView_Previews: PreviewProvider {
    static var previews: some View {
        // Crear datos de ejemplo para la vista previa
        let detalleRubro = DetallesRubroDto(descripcion: "AJU_IMPUESTO", anio: 2022, valor: 535.7)
        
        let detallesRubrosModel = [detalleRubro.toDomain]
        
        // Estado temporal para simular el Binding de tipo Bool
        //@State var rubro: Rubro? = nil
        @State var isPresented = true
        
        DetalleRubrosView(detalleRubros: detallesRubrosModel, descripcionRubro: "TASA JUNTA BEN. GUAYAQUIL", cerrarSheet: {})
    }
}
