//
//  LoginView.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

struct LoginContainerView: View {
    var body: some View {
        LoginView()
    }
}

// MARK: - ViewModel
/*class LoginViewModel: ObservableObject {
    @Published var ruc: String = ""
    @Published var ciAdicional: String = ""
    @Published var clave: String = ""
    
    @Published var isPasswordVisible: Bool = false
    
    func login() {
        // Implementar la lógica de autenticación aquí
        print("Iniciar sesión con RUC: \(ruc), CI Adicional: \(ciAdicional), Clave: \(clave)")
    }
}*/

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

struct SriTextField: View {
    @Binding var texto: String
    @FocusState var activo
    var titulo: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $texto)
                .padding(.leading)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .focused($activo)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            Text(titulo)
                .padding(.leading)
                .foregroundColor((activo || !texto.isEmpty) ? .black : .gray)
                //.offset(y: (activo || !texto.isEmpty) ? -50 : 0)
                //.scaleEffect((activo || !texto.isEmpty) ? 0.8 : 1.0, anchor: .leading)
                //.animation(.spring, value: activo)
                .offset(y: (!activo && texto.isEmpty) ? 0 : -50)
                .scaleEffect((!activo && texto.isEmpty) ? 1.0 : 0.8, anchor: .leading)
                .animation((activo || !texto.isEmpty) ? .spring() : .none, value: activo)

                .onTapGesture {
                    activo = true
                }
        }
    }
}

struct SriSecureTextField: View {
    @Binding var texto: String
    @FocusState var activo
    var titulo: String
    @State private var isPasswordVisible = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Campo de texto o seguro según `isPasswordVisible`
            if isPasswordVisible {
                TextField("", text: $texto)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .focused($activo)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            } else {
                SecureField("", text: $texto)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .focused($activo)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            }
            
            // Placeholder con animación
            Text(titulo)
                .padding(.leading)
                .foregroundColor((activo || !texto.isEmpty) ? .black : .gray) // Cambiar color cuando está activo o con texto
                //.offset(y: (activo || !texto.isEmpty) ? -50 : 0)
                //.scaleEffect((activo || !texto.isEmpty) ? 0.8 : 1.0, anchor: .leading)
                //.animation(.spring, value: activo)
                .offset(y: (!activo && texto.isEmpty) ? 0 : -50)
                .scaleEffect((!activo && texto.isEmpty) ? 1.0 : 0.8, anchor: .leading)
                .animation((activo || !texto.isEmpty) ? .spring() : .none, value: activo)
                .onTapGesture {
                    activo = true
                }
            
            // Botón de "ojo" para mostrar/ocultar contraseña
            HStack {
                Spacer()
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
            }
        }
    }
}



// MARK: - Main Login View
struct LoginView: View {
    //@StateObject private var viewModel = LoginViewModel()
    @State var identificacion: String = ""
    @State var adicional: String = ""
    @State var clave: String = ""
    
    var body: some View {
        
        VStack {
            Image(.logoSRI)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(.bottom, 30)
                .padding(.top, 40)
        }
        
        VStack(spacing: 45) {
            /*Image("Logo-SRI") // Aquí debería ir la imagen que subiste
                .resizable()
                .scaledToFit()
                //.frame(height: 150)
                .frame(maxWidth: .infinity)
                .padding(.top, 40)*/
            
            SriTextField(texto: $identificacion, titulo: "RUC, Cédula o Pasaporte")
            
            SriTextField(texto: $adicional, titulo: "En caso de requerir")
            
            SriSecureTextField(texto: $clave, titulo: "Ingrese su clave")
            
            //SriTextField(texto: $clave, titulo: "Ingrese su clave")
            
            /*
            CustomTextField(text: $viewModel.ruc, placeholder: "RUC, Cédula o Pasaporte", icon: nil)
                .padding(.bottom, 25)
            
            CustomTextField(text: $viewModel.ciAdicional, placeholder: "En caso de requerir", icon: nil)
                .padding(.bottom, 25)
            
            CustomSecureField(text: $viewModel.clave, placeholder: "Ingrese su clave", isPasswordVisible: $viewModel.isPasswordVisible)
                .padding(.bottom, 30)
            */

            
            Button(action: {
                // TODO
                //viewModel.login()
            }) {
                Text("Ingresar")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("Primary"))
                    .cornerRadius(8)
            }
            .disabled(identificacion.isEmpty || clave.isEmpty) // Deshabilitar si los campos están vacíos
            .opacity(identificacion.isEmpty || clave.isEmpty ? 0.5 : 1.0)
            
            Spacer()
        }
        .padding()
        
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}

#Preview {
    @Previewable @State var cedula: String = ""
    SriTextField(texto: $cedula, titulo: "Ruc, Cédula o Pasaporte")
}

#Preview {
    @Previewable @State var clave: String = ""
    SriSecureTextField(texto: $clave, titulo: "Ingrese la clave")
}
