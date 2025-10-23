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
        
        MainLayout{
            
            Text("Perfil")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.white)
                .padding(.top)
            
            
            VStack{
                
                (auth.getUserProfileImage() ?? Images.Placeholder.profileDefault)
                
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 118.0, height: 118.0)
                    .clipShape(Circle())
                
                Text(auth.currentUser?.username ?? "Usuario")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
            }
            .padding(.vertical)
            
            Settings()
                .padding(.horizontal, -16)
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
            
            Spacer()
        }
    }
}

struct Settings: View {
    
    @State var isToggleOn = true
    @State var isEditProfileViewActive = false
    @State var isTemporalViewActive = false
    
    var body: some View {
        
        VStack (spacing: 3){
            
            Text("Ajustes")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .foregroundStyle(.white)
                .padding(.bottom)
            
            SettingButton(text: "Cuenta") {
                isTemporalViewActive = true
            }
            
            HStack{
                Text("Notificaciones")
                Spacer()
                Toggle("", isOn: $isToggleOn)
                    .tint(Color.appSecondaryBackground)
            }
            .foregroundStyle(.white)
            .padding()
            .background(Color.appPrimaryButton)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            
            SettingButton(text: "Editar Perfil") {
                isEditProfileViewActive = true
            }
            
            SettingButton(text: "Califica esta aplicación") {
                isTemporalViewActive = true
            }
        }
        .navigationDestination(isPresented: $isEditProfileViewActive) {
            EditProfileView()
        }
        .navigationDestination(isPresented: $isTemporalViewActive) {
            TemporalView()
        }
    }
}

struct SettingButton: View {
    
    @State var text: String
    @State var action: () -> Void
    
    var body: some View {
        Button (action: action, label: {
            HStack{
                Text(text)
                Spacer()
                Text(">")
            }
            .foregroundStyle(.white)
            .padding()
        })
        .background(Color.appPrimaryButton)
        .clipShape(RoundedRectangle(cornerRadius: 5.0))
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
