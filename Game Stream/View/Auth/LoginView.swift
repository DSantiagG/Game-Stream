//
//  LoginView.swift
//  Game Stream
//
//  Created by David Giron on 16/10/25.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View{
        ScrollView {
            VStack (alignment: .leading){
                CustomTextField(label: "Correo electrónico", placeHolder: "ejemplo@gmail.com", text: $auth.email)
                    .padding(.bottom)
                
                CustomTextField(label: "Contraseña", placeHolder: "Escribe tu contraseña", text: $auth.password, isSecure: true)
                    .padding(.bottom)
                
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundStyle(Color.appSecondaryBackground)
                    .padding(.bottom, 50)
                
                PrimaryButton(title: "INICIAR SESIÓN", action: auth.login)
                
                if let error = auth.loginError {
                    Text(error)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Text ("Inicia sesión con redes sociales")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 50)
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
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
