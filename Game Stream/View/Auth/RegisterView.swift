//
//  RegisterView.swift
//  Game Stream
//
//  Created by David Giron on 16/10/25.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View{
        
        ScrollView {
            VStack(alignment: .center){
                
                Text("Elije una foto de perfil")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("Puedes cambiar o ejegirla más adelante")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                ImagePicker (image: $auth.profileImage) {
                    (
                        auth.profileImage != nil ?
                        Image(uiImage: auth.profileImage!) :
                        Images.Placeholder.profileDefault
                    )
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .overlay {
                            Image(systemName: "camera")
                                .foregroundStyle(.white)
                        }
                        .clipShape(Circle())
                }
                .padding(.bottom)
            }
            VStack (alignment: .leading){
                
                CustomTextField(label: "Nombre de usuario*", placeHolder: "juanPerez", text: $auth.userName)
                    .padding(.bottom)
                
                CustomTextField(label: "Correo electrónico*", placeHolder: "ejemplo@gmail.com", text: $auth.email)
                    .padding(.bottom)
                
                CustomTextField(label: "Contraseña*", placeHolder: "Escribe tu contraseña", text: $auth.password, isSecure: true)
                    .padding(.bottom)
                
                CustomTextField(label: "Confirmar Contraseña*", placeHolder: "Vuelve a escribir tu contraseña", text: $auth.confirmPassword, isSecure: true)
                    .padding(.bottom)
                
                PrimaryButton(title: "REGISTRATE", action: auth.register)
                
                if let error = auth.loginError {
                    Text(error)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Text ("Inicia sesión con redes sociales")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                    .padding(.bottom)
                
                HStack (alignment: .center){
                    SecondaryButton(title: "Facebook", action: {})
                    
                    SecondaryButton(title: "Twitter", action: {})
                }.frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

#Preview {
    MainLayout{
        RegisterView()
            .environmentObject(AuthViewModel())
    }
}
