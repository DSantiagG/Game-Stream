//
//  EditProfileView.swift
//  Game Stream
//
//  Created by David Giron on 13/10/25.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        MainLayout{
            ScrollView{
                ImagePicker (image: $auth.profileImage, title: "Cambiar foto de perfil") {
                    (
                        auth.profileImage != nil ?
                        Image(uiImage: auth.profileImage!) :
                            Images.Placeholder.profileDefault
                    )
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 118, height: 118)
                    .overlay {
                        Image(systemName: "camera")
                            .font(.system(size: 24))
                            .foregroundStyle(.white)
                    }
                    .clipShape(Circle())
                }
                .padding(.bottom, 18)
                EditSection()
            }
        }
        .navigationTitle("Editar perfil")
    }
}

struct EditSection: View {
    
    @EnvironmentObject var auth: AuthViewModel
    
    @State private var showSuccessMessage = false
    
    var body: some View{
        VStack (alignment: .leading, spacing: 30){
            
            CustomTextField(label: "Nombre de usuario", placeHolder: "Introduce tu nuevo nombre de usuario", text: $auth.userName)

            CustomTextField(label: "Contraseña", placeHolder: "Introduce tu nueva contraseña", text: $auth.password, isSecure: true)
                .padding(.bottom)
            
            CustomTextField(label: "Confirmar Contraseña", placeHolder: "Vuelve a escribir tu contraseña", text: $auth.confirmPassword, isSecure: true)
                .padding(.bottom)
            
            PrimaryButton(title: "ACTUALIZAR DATOS", action: {
                if auth.update() {
                    showSuccessMessage = true
                }
            })
            
            if let error = auth.loginError {
                Text(error)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .alert(isPresented: $showSuccessMessage) {
            Alert(title: Text("Datos actualizados con éxito"))
        }
    }
}

#Preview("EditProfile en stack con back") {
    NavigationStack {
        ParentViewSimulada()
    }
    .environmentObject(AuthViewModel())
}

private struct ParentViewSimulada: View {
    @State private var path: [String] = ["edit"] // Empuja de una vez

    var body: some View {
        NavigationStack(path: $path) {
            Text("Pantalla Padre")
                .navigationTitle("Padre")
                .navigationDestination(for: String.self) { value in
                    if value == "edit" {
                        EditProfileView()
                    }
                }
        }
    }
}
