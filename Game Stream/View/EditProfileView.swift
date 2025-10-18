//
//  EditProfileView.swift
//  Game Stream
//
//  Created by David Giron on 13/10/25.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @State private var showingOptions = false
    @State private var showingCamera = false
    @State private var showingGallery = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image? = Image("perfilEjemplo")
    @State private var profileUIImage: UIImage?
    
    var body: some View {
        ZStack{
            Color("Marine")
                .ignoresSafeArea()
            ScrollView{
                VStack{
                    Button {
                        showingOptions = true
                    } label: {
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
                .confirmationDialog("Cambiar foto de perfil", isPresented: $showingOptions, titleVisibility: .visible) {
                    Button("Tomar foto") {
                        showingCamera = true
                    }
                    Button("Elegir de la galería") {
                        showingGallery = true
                    }
                    Button("Cancelar", role: .cancel) {}
                }
                .photosPicker(isPresented: $showingGallery, selection: $selectedItem, matching: .images)
                .fullScreenCover(isPresented: $showingCamera) {
                    CameraPicker { uiImage in
                        profileUIImage = uiImage
                        profileImage = Image(uiImage: uiImage)
                        saveProfileImage(uiImage)
                    }
                    .ignoresSafeArea()
                }
                .onChange(of: selectedItem) { _, newItem in
                    Task {
                        guard let data = try? await newItem?.loadTransferable(type: Data.self),
                              let uiImage = UIImage(data: data) else { return }
                        profileUIImage = uiImage
                        profileImage = Image(uiImage: uiImage)
                        saveProfileImage(uiImage)
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
                .foregroundStyle(Color("Dark-Cian"))

            TextField(text: $correo) {
                Text(verbatim: "ejemplo@gmail.com")
                    .font(.caption)
                    .foregroundColor(.gray)
            }.foregroundStyle(.white)
            
            Divider()
                .frame(height: 1)
                .background(Color("Dark-Cian"))
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
                        .stroke(Color("Dark-Cian"), lineWidth: 1.0)
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
