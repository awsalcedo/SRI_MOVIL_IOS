//
//  BannerView.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import SwiftUI
import Factory

struct BannerView: View {
    @InjectedObject(\.obtenerBannerViewModel) var viewModel: BannerViewModel
    
    var body: some View {
        VStack {
            switch viewModel.estado {
            case .inicial:
                BarraProgresoView()
                    .onAppear {
                        viewModel.obtenerBanner()
                    }
                    /*.task {
                        viewModel.obtenerBanner()
                    }*/
                    /*.onAppear {
                        Task {
                            viewModel.obtenerBanner()
                        }
                    }*/
            case .cargando:
                BarraProgresoView()
            case .cargado(let banner):
                if let url = URL(string: banner.url) {
                    Link(destination: url) {
                        AsyncImage(url: URL(string: banner.imagen64)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .clipped()
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        } placeholder: {
                            BarraProgresoView()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                
            case .error(let error):
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)
                    .padding()
            }
        }
        .animation(.easeInOut, value: viewModel.estado)
        .padding()
    }
}

#Preview {
    BannerView()
}
