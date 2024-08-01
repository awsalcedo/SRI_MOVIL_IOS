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
                
                List(servicios, id: \.nombreServicio) { servicio in
                    NavigationLink(destination: servicio.vista) {
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
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationTitle("Servicios")
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
