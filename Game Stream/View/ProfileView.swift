//
//  ProfileView.swift
//  Game Stream
//
//  Created by David Giron on 13/10/25.
//

import SwiftUI

struct ProfileView: View {
    @State var userName = "Lorem"
    @State var profileUIImage: UIImage = UIImage(named: "perfilEjemplo")!
    
    var body: some View {
        ZStack{
            Color("Marine")
                .ignoresSafeArea()
            
            VStack{
                Text("Perfil")
                    .font(.title.bold())
                VStack{
                    Image(uiImage: profileUIImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 118.0, height: 118.0)
                        .clipShape(Circle())
                    Text(userName)
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
        .onAppear {
            print("Revisando si tengo datos de usuario en mis UserDefaults")
            
            if let savedImage = loadProfileImage() {
                profileUIImage = savedImage
            }else{
                print("No encontre foto de perfil guardada en el dispositivo")
            }
            
            if UserDefaults.standard.object(forKey: "userData") != nil {
                userName = UserDefaults.standard.stringArray(forKey: "userData")![2]
            }else{
                print("No encontre informacion del usuario")
            }
        }
    }
    func loadProfileImage() -> UIImage? {
        let filename = getDocumentsDirectory().appendingPathComponent("profile.jpg")
        if FileManager.default.fileExists(atPath: filename.path) {
            return UIImage(contentsOfFile: filename.path)
        } else {
            return nil
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

}

struct Settings: View {
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
            .background(Color("Blue-Gray"))
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
            .background(Color("Blue-Gray"))
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
            .background(Color("Blue-Gray"))
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
            .background(Color("Blue-Gray"))
            .clipShape(RoundedRectangle(cornerRadius: 5.0))

        }
        .navigationDestination(isPresented: $isEditProfileViewActive) {
            EditProfileView()
        }
    }
}

#Preview {
    ProfileView()
}
