//
//  ConsultasCardView.swift
//  SriMovil
//
//  Created by usradmin on 17/10/24.
//

import SwiftUI

struct ConsultasCardView: View {
    var nombreImagen: String?
    var tituloServicio: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 6.0) {
            if let nombreImagen = nombreImagen {
                Image(nombreImagen)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 125, height: 65)
                    .padding()
                    
                VStack(alignment: .leading) {
                    Text(tituloServicio)
                        .font(.system(size: 11))
                        .bold()
                        
                }
                .frame(width: 125, height: 65)

                
            } else {
                Text(tituloServicio)
                    .font(.footnote)
                    .padding()
                Spacer()
            }
            
        }
        .frame(width: 125, height: 175)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24.0))
        .shadow(radius: 8.0)
    }
}

#Preview {
    ConsultasCardView(nombreImagen: "comprobantes_electronicos_boton", tituloServicio: "Comprobantes electrónicos")
}
