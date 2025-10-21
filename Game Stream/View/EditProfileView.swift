//
//  EditProfileView.swift
//  Game Stream
//
//  Created by David Giron on 13/10/25.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @State private var profileUIImage: UIImage?
    
    @State private var profileImage: Image? = Images.Placeholder.profileDefault
    
    var body: some View {
        ZStack{
            Color.appPrimaryBackground
                .ignoresSafeArea()
            ScrollView{
                VStack{
                    ImagePicker (image: $profileUIImage, title: "Cambiar foto de perfil"){
                        ZStack{
                            profileImage!
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 118, height: 118)
                                .clipShape(Circle())
                            
                            Image(systemName: "camera")
                                .font(.system(size: 24))
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.bottom, 18)
                .onChange(of: profileUIImage) { _, newValue in
                    if let profileUIImage{
                        profileImage = Image(uiImage: profileUIImage)
                        saveProfileImage(profileUIImage)
                    }
                }
                EditSection()
            }
        }
        .navigationTitle("Editar Perfil")
        .toolbar(.visible)
        .onAppear {
            if let savedImage = loadProfileImage() {
                profileUIImage = savedImage
                profileImage = Image(uiImage: savedImage)
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

    func saveProfileImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        let filename = getDocumentsDirectory().appendingPathComponent("profile.jpg")
        try? data.write(to: filename)
        print("Imagen guardada en:", filename)
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

}

struct EditSection: View {
    @State var correo: String = ""
    @State var contrasena: String = ""
    @State var nombre: String = ""
    
    var body: some View{
        VStack (alignment: .leading){
            Text("Correo electrónico")
                .foregroundStyle(Color.appSecondaryBackground)

            TextField(text: $correo) {
                Text(verbatim: "ejemplo@gmail.com")
                    .font(.caption)
                    .foregroundColor(.gray)
            }.foregroundStyle(.white)
            
            Divider()
                .frame(height: 1)
                .background(Color.appSecondaryBackground)
                .padding(.bottom)
            
            Text("Contraseña")
                .foregroundStyle(.white)

            SecureField(text: $contrasena) {
                Text("Introduce tu nueva contraseña")
                    .font(.caption)
                    .foregroundColor(.gray)
            }.foregroundStyle(.white)
            
            Divider()
                .frame(height: 1)
                .background(.gray)
                .padding(.bottom)
            
            Text("Nombre")
                .foregroundStyle(.white)

            TextField(text: $nombre) {
                Text("Introduce tu nombre de usuario")
                    .font(.caption)
                    .foregroundColor(.gray)
            }.foregroundStyle(.white)
            
            Divider()
                .frame(height: 1)
                .background(.gray)
                .padding(.bottom, 32)
            
            Button {
                updateUserData()
            } label: {
                Text("ACTUALIZAR DATOS")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 10)
                    .overlay(RoundedRectangle(cornerRadius: 6.0)
                        .stroke(Color.appSecondaryBackground, lineWidth: 1.0)
                        .shadow(color: .white, radius: 6))
            }
            
        }
        .padding()
    }
    
    func updateUserData() {
        let saveData = SaveData()
        let resultado = saveData.saveData(correo: correo, contrasena: contrasena, nombre: nombre)
        print("Se guardaron los datos con exito? \(resultado)")
    }
}

#Preview {
    EditProfileView()
}
