//
//  EstadoTributarioDetalleView.swift
//  SriMovil
//
//  Created by usradmin on 9/10/24.
//

import SwiftUI

struct EstadoTributarioDetalleView: View {
    
    let infoEstadoTributario: EstadoTributarioModel
    
    // Estado para controlar la presentación del sheet y almacenar la obligación seleccionada
    @State private var obligacionSeleccionada: ObligacionesPendientesModel?
    
    var body: some View {
        VStack {
            CabeceraInfoEstadoTributarioView(infoEstadoTributario: infoEstadoTributario, onObligacionSeleccionada: { obligacion in
                obligacionSeleccionada = obligacion
            })
            Spacer()
        }
        // Muestra el sheet con la obligación seleccionada
        .sheet(item: $obligacionSeleccionada) { obligacion in
            DetalleObligacionSheetView(obligacionPendiente: obligacion) {
                self.obligacionSeleccionada = nil
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
    }
}

struct CabeceraInfoEstadoTributarioView: View {
    let infoEstadoTributario: EstadoTributarioModel
    
    let onObligacionSeleccionada: (ObligacionesPendientesModel) -> Void
    
    var body: some View {
        Form {
            Section {
                Text(infoEstadoTributario.razonSocial)
                    .font(.title2)
                    .bold()
                CustomLabeledContent(label: "RUC:", value: infoEstadoTributario.ruc)
                CustomLabeledContent(label: "Razón Social:", value: infoEstadoTributario.razonSocial)
                CustomLabeledContent(label: "Estado Tributario:", value: infoEstadoTributario.descripcion)
                CustomLabeledContent(label: "Plazo Vigencia:", value: infoEstadoTributario.plazoVigenciaDoc)
                CustomLabeledContent(label: "Clase de Contribuyente:", value: infoEstadoTributario.claseContribuyente)
                
            }
            
            // Lista de obligaciones pendientes
            if let obligacionesPendientes = infoEstadoTributario.obligacionesPendientes {
                List {
                    Section(header: Text("OBLIGACIONES PENDIENTES")) {
                        ForEach(obligacionesPendientes) { obligacionPendiente in
                            ObligacionPendienteItemView(obligacionPendiente: obligacionPendiente, onObligacionSeleccionada: onObligacionSeleccionada)
                        }
                    }
                }
            }
        }
        FooterView()
    }
}

struct FooterView: View {
    var body: some View {
        VStack {
            Divider()
                .padding(.horizontal, 20)
            Text("El tiempo reflejado en el Plazo de Vigencia de los Documentos, corresponde al tiempo que tendrá vigencia los documentos impresos en el día de hoy. ")
                .padding(.horizontal, 20)
                .font(.custom("", size: 9.0))
                .foregroundColor(.gray)
        }
    }
}

struct CustomLabeledContent: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.footnote)
                .bold()  // Descripción en negrita
            Spacer()
            Text(value)
                .font(.footnote)  // Valor con tamaño de texto footnote
                .multilineTextAlignment(.trailing)  // Alineación a la derecha
                .padding(.leading)
        }
        .padding(.vertical, 3)  // Espacio entre elementos
    }
}


struct ObligacionPendienteItemView: View {
    let obligacionPendiente: ObligacionesPendientesModel
    let onObligacionSeleccionada: (ObligacionesPendientesModel) -> Void
    
    var body: some View {
        Button(action: {
            // Al presionar, se selecciona la obligación y se muestra el sheet
            onObligacionSeleccionada(obligacionPendiente)
        }) {
            Label(obligacionPendiente.descripcion, systemImage: "doc.text")
                .font(.caption)
                .bold()
                .padding(.top, 3)
        }
    }
}

struct DetalleObligacionSheetView: View {
    let obligacionPendiente: ObligacionesPendientesModel
    var cerrarSheet: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Text("Detalle de la obligación")
                    .font(.title3)
                    .bold()
                    .padding()
                
                Spacer()
                
                Button {
                    cerrarSheet()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 15))
                        .foregroundStyle(.black)
                        .padding(.horizontal, 5)
                }

            }
            
            
            Text(obligacionPendiente.descripcion)
                .font(.caption)
            
            Divider()
            
            if !obligacionPendiente.periodos.isEmpty {
                List(obligacionPendiente.periodos, id: \.self) { periodo in
                    CustomLabeledContent(label: "Periodo:", value: periodo)
                }
            } else {
                Text("No hay periodos asociados")
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    let obigacionesPendientes: [ObligacionesPendientesModel] = [
        ObligacionesPendientesModel(descripcion: "CONTRIBUYENTE MANTIENE DEUDAS FIRMES", periodos: []),
        ObligacionesPendientesModel(descripcion: "1024 IMPUESTO A LA RENTA REGIMEN IMPOSITIVO PARA MICROEMPRESAS", periodos: ["SEGUNDO SEMESTRE 2020", "PRIMER SEMESTRE 2021", "SEGUNDO SEMESTRE 2021"]),
        ObligacionesPendientesModel(descripcion: "DECLARACIÓN DE IMPUESTO A LA RENTA", periodos: ["AÑO 2023"]),
        ObligacionesPendientesModel(descripcion: "DECLARACIÓN DE IVA", periodos: ["DICIEMBRE 2020", "JUNIO 2021", "DICIEMBRE 2021"]),
        ObligacionesPendientesModel(descripcion: "DECLARACIÓN DE IVA PAGO", periodos: ["DICIEMBRE 2020", "JUNIO 2021", "DICIEMBRE 2021"]),
        ObligacionesPendientesModel(descripcion: "IMPUESTO A LA RENTA PAGO", periodos: ["AÑO 2023"])
    ]
    let estadoTributario: EstadoTributarioModel = EstadoTributarioModel(ruc: "1003360144001", razonSocial: "TORRES SANTACRUZ VANESSA XIMENA", descripcion: "OBLIGACIONES PENDIENTES", plazoVigenciaDoc: "0 meses", claseContribuyente: "Régimen RIMPE negocios populares", obligacionesPendientes: obigacionesPendientes)
    EstadoTributarioDetalleView(infoEstadoTributario: estadoTributario)
}
