//
//  ToastTwoView.swift
//  SriMovil
//
//  Created by usradmin on 8/8/24.
//

import Foundation
import SwiftUI

struct Toast: Equatable {
    var mensaje: String
    var duracion: Double = 3.5
    var ancho: Double = .infinity
}

struct ToastTwoView: View {
    
    var mensaje: String
    var ancho = CGFloat.infinity
    
    var body: some View {
        HStack(alignment: .center) {
            Text(mensaje)
                .font(Font.footnote)
                .foregroundColor(Color(.black))
            
            Spacer()
        }
        .padding()
        .frame(minWidth: 0, maxWidth: ancho)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal, 10)
    }
}

struct ToastModifier: ViewModifier {
    
    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: 320)
                }
                    .animation(.spring(), value: toast)
            )
            .onChange(of: toast) {
                showToast()
            }
    }
    
    @ViewBuilder
    func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                ToastTwoView (mensaje: toast.mensaje, ancho: toast.ancho)
                Spacer()
            }
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        if toast.duracion > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duracion, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
