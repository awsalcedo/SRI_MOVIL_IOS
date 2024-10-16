//
//  ConsultasView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct ConsultasView: View {
    
    @State private var showModal = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                /*BannerView()
                    .frame(maxHeight: 200)*/
                
                List(servicios, id: \.nombreServicio) { servicio in
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
            }
            .sheet(isPresented: $showModal) {
                ConfiguracionView()
            }
            .toolbarBackground(.blue, for: .navigationBar)
            .navigationTitle("Servicios")
        }
    }
    
    
    @ViewBuilder
    func viewForServicio(_ vista: ServicioViewType) -> some View {
        switch vista {
        case .comprobantes:
            ComprobantesView()
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
