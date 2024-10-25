//
//  LoginView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

// MARK: - ViewModel
class LoginViewModel: ObservableObject {
    @Published var ruc: String = ""
    @Published var ciAdicional: String = ""
    @Published var clave: String = ""
    
    @Published var isPasswordVisible: Bool = false
    
    func login() {
        // Implementar la lógica de autenticación aquí
        print("Iniciar sesión con RUC: \(ruc), CI Adicional: \(ciAdicional), Clave: \(clave)")
    }
}

// MARK: - Custom Views
struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var icon: String?
    
    var body: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.gray)
            }
            TextField(placeholder, text: $text)
                .padding(.vertical, 10)
                .padding(.leading, 5)
        }
        .padding(.horizontal, 10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}

struct CustomSecureField: View {
    @Binding var text: String
    var placeholder: String
    var isPasswordVisible: Binding<Bool>
    
    var body: some View {
        HStack {
            if isPasswordVisible.wrappedValue {
                TextField(placeholder, text: $text)
            } else {
                SecureField(placeholder, text: $text)
            }
            
            Button(action: {
                isPasswordVisible.wrappedValue.toggle()
            }) {
                Image(systemName: isPasswordVisible.wrappedValue ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}

// MARK: - Main Login View
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Image("Logo-SRI") // Aquí debería ir la imagen que subiste
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.top, 40)
                        
            CustomTextField(text: $viewModel.ruc, placeholder: "RUC, Cédula o Pasaporte", icon: nil)
                .padding(.bottom, 25)
            
            CustomTextField(text: $viewModel.ciAdicional, placeholder: "En caso de requerir", icon: nil)
                .padding(.bottom, 25)
            
            CustomSecureField(text: $viewModel.clave, placeholder: "Ingrese su clave", isPasswordVisible: $viewModel.isPasswordVisible)
                .padding(.bottom, 30)
            

            
            Button(action: {
                viewModel.login()
            }) {
                Text("Ingresar")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("Primary"))
                    .cornerRadius(8)
            }
            .disabled(viewModel.ruc.isEmpty || viewModel.clave.isEmpty) // Deshabilitar si los campos están vacíos
            .opacity(viewModel.ruc.isEmpty || viewModel.clave.isEmpty ? 0.5 : 1.0)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationBarTitle("Volver", displayMode: .inline)
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
