//
//  ProfileView.swift
//  Game Stream
//
//  Created by David Giron on 13/10/25.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        ZStack{
            Color.appPrimaryBackground
                .ignoresSafeArea()
            
            VStack{
                Text("Perfil")
                    .font(.title.bold())
                VStack{
                    (
                        auth.profileImage != nil ?
                        Image(uiImage: auth.profileImage!) :
                        Images.Placeholder.profileDefault
                    )
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 118.0, height: 118.0)
                        .clipShape(Circle())
                    Text(auth.currentUser?.username ?? "Usuario")
                        .font(.title3.bold())
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 32, trailing: 0))
                
                Text("Ajustes")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                Settings()
                
                Spacer()
                
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
        }
    }
}

struct Settings: View {
    
    @EnvironmentObject var auth: AuthViewModel
    @State var isToggleOn = true
    @State var isEditProfileViewActive = false
    var body: some View {
        VStack (spacing: 3){
            
            Button {
                print("Cuenta")
            } label: {
                HStack{
                    Text("Cuenta")
                    Spacer()
                    Text(">")
                }
                .foregroundStyle(.white)
                .padding()
            }
            .background(Color.appPrimaryButton)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            
            Button {
                print("Notificaciones")
            } label: {
                HStack{
                    Text("Notificaciones")
                    Spacer()
                    Toggle("", isOn: $isToggleOn)
                }
                .foregroundStyle(.white)
                .padding()
            }
            .background(Color.appPrimaryButton)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            
            Button {
                isEditProfileViewActive = true
            } label: {
                HStack{
                    Text("Editar Perfil")
                    Spacer()
                    Text(">")
                }
                .foregroundStyle(.white)
                .padding()
            }
            .background(Color.appPrimaryButton)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            
            Button {
                print("Califica esta aplicación")
            } label: {
                HStack{
                    Text("Califica esta aplicación")
                    Spacer()
                    Text(">")
                }
                .foregroundStyle(.white)
                .padding()
            }
            .background(Color.appPrimaryButton)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            .padding(.bottom)
            
            Button {
                auth.logout()
            } label: {
                HStack{
                    Image(systemName: "arrow.right.square")
                    Text("Cerrar Sesión")
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background(Color.appPrimaryButton)
            .clipShape(RoundedRectangle(cornerRadius: 30))

        }
        .navigationDestination(isPresented: $isEditProfileViewActive) {
            EditProfileView()
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
