//
//  ConsultasView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct ConsultasView: View {
    
    @State private var showModal = false
    
    @State private var textoBuscar = ""
    
    var serviciosFiltrados: [Servicio] {
        guard !textoBuscar.isEmpty else {return servicios}
        return servicios.filter{$0.nombreServicio.localizedCaseInsensitiveContains(textoBuscar)}
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                /*BannerView()
                 .frame(maxHeight: 200)*/
                
                /*List(servicios, id: \.nombreServicio) { servicio in
                 NavigationLink(destination: viewForServicio(servicio.vista)) {
                 ListItemView(imageName: servicio.imagenServicio, title: servicio.nombreServicio)
                 }
                 .listRowBackground(Color(.systemGray6))
                 .listRowSeparator(.hidden)
                 .padding(.vertical, 5)
                 .padding(.horizontal, 8)
                 .background(
                 RoundedRectangle(cornerRadius: 10)
                 .fill(Color.white)
                 .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                 )
                 
                 }
                 .listStyle(PlainListStyle())
                 */
                
                let columnas = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
                
                ScrollView {
                    LazyVGrid(columns: columnas, spacing: 10) {
                        ForEach(serviciosFiltrados) { servicio in
                            NavigationLink(destination: viewForServicio(servicio.vista)) {
                                ConsultasCardView(nombreImagen: servicio.imagenServicio, tituloServicio: servicio.nombreServicio)
                                    .padding()
                                /*Permite hacer efectos a las vistas secundarias del ScrollView mediante el uso del modificador .scrollTransition, para personalizar como se activan y desactivan las vistas secundarias en la pantalla.
                                Al modificador se le pasa un closure que acepte al menos dos parámetros: * - - content que es la vista secundaria dentro del área del SrcollView
                                    - phase que corresponde a la fase de transición de desplazamiento, la phase puede tener uno de estos tres valores:
                                        * phase.identity significa que la vista es visible en la pantalla
                                        * phase.topLeading donde la vista está apunto de volverse visible
                                          desde el borde superior o el borde principal según la dirección de desplazamiento del ScrollView
                                        * phase.bottomTrailing es lo opuesto de .topLeading inferior/posterior
                                 (.animated.threshold(.visible(0.9))) le podemos indicar el porcentaje de visibilidad de la vista antes de que se muestre o se elimine, en este caso el 90%
                                    */
                                    .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1 : 0)
                                            .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                            .blur(radius: phase.isIdentity ? 0 : 10)
                                    }
                            }
                            
                        }
                    }
                }
                
            }
            .sheet(isPresented: $showModal) {
                ConfiguracionView()
            }
            .toolbarBackground(.blue, for: .navigationBar)
            .navigationTitle("Servicios")
        }
        .searchable(text: $textoBuscar, prompt: "Buscar servicios")
    }
    
    
    @ViewBuilder
    func viewForServicio(_ vista: ServicioViewType) -> some View {
        switch vista {
        case .comprobantes:
            LoginView()
        case .estadoTributario:
            EstadoTributarioView()
        case .valoresPagar:
            MatriculacionVehicularView()
            //MatriculacionVehicularToastView()
        case .deudas:
            DeudasView()
        case .validezDocumentos:
            ValidacionDocumentosView()
        case .impuestoRenta:
            ImpuestoRentaView()
        case .certificados:
            CertificadosView()
        case .seguimientoTramites:
            SeguimientoTramitesView()
        case .validacionQR:
            ValidacionQRView()
        case .citaPrevia:
            CitaPreviaView()
        case .calculadoras:
            CalculadorasView()
        case .denuncias:
            DenunciasView()
        case .contactenos:
            ContactenosView()
        case .simar:
            SimarView()
        case .facturadorSRI:
            FacturadorSRIView()
        case .configuracion:
            ConfiguracionView()
        case .politicaProteccionDatos:
            PoliticaProteccionDatosView()
        }
    }
    
    
}

struct ListItemView: View {
    var imageName: String?
    var title: String
    
    var body: some View {
        HStack {
            if let imageName = imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 10)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.black)
                
            } else {
                Spacer()
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}


#Preview {
    ConsultasView()
}
