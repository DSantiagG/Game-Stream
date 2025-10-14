//
//  ContentView.swift
//  Game Stream
//
//  Created by David Giron on 8/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack() {
            ZStack{
                Spacer()
                Color("Marine")
                    .ignoresSafeArea()
                VStack{
                    Image("appLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .padding(.bottom, 40)
                    
                    InicioYRegistroView()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                
            }
            .toolbar(.hidden)
        }
        
    }
}

struct InicioYRegistroView: View{
    
    @State var tipoInicioSesion = true
    
    var body: some View{
        VStack{
            HStack {
                Spacer()
                Button("INICIA SESIÓN"){
                    tipoInicioSesion = true
                }
                .foregroundStyle(tipoInicioSesion ? .white : .gray)
                
                Spacer()
                
                Button("REGÍSTRATE"){
                    tipoInicioSesion = false
                }
                .foregroundStyle(tipoInicioSesion ? .gray : .white)
                Spacer()
            }
            
            Spacer(minLength: 42)
            
            if tipoInicioSesion {
                InicioSesionView()
            } else {
                RegistroView()
            }
        }
    }
}

struct InicioSesionView: View{
    
    @State var correo = ""
    @State var contraseña = ""
    @State var isLoggedIn = false
    
    
    
    var body: some View{
        ScrollView {
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
                
                SecureField(text: $contraseña) {
                    Text("Escribe tu contraseña")
                        .font(.caption)
                        .foregroundColor(.gray)
                }.foregroundStyle(.white)
                
                Divider()
                    .frame(height: 1)
                    .background(Color("Dark-Cian"))
                    .padding(.bottom)
                
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundStyle(Color("Dark-Cian"))
                    .padding(.bottom, 50)
                
                Button {
                    iniciarSesion()
                } label: {
                    Text("INICIAR SESIÓN")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 10)
                        .overlay(RoundedRectangle(cornerRadius: 6.0)
                            .stroke(Color("Dark-Cian"), lineWidth: 1.0)
                            .shadow(color: .white, radius: 6))
                }
                
                Text ("Inicia sesión con redes sociales")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 50)
                    .padding(.bottom)
                
                HStack (alignment: .center){
                    Button{
                        print("Facebook")
                    } label:{
                        Text("Facebook")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 150, height: 40)
                            .background(Color("Blue-Gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    Button{
                        print("Twitter")
                    } label:{
                        Text("Twitter")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 150, height: 40)
                            .background(Color("Blue-Gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }.frame(maxWidth: .infinity, alignment: .center)
                
            }
        }
        .navigationDestination(isPresented: $isLoggedIn) {
            Home()
        }
    }
    
    func iniciarSesion() {
        print("Iniciando sesion...")
        isLoggedIn = true
    }
    
}



struct RegistroView: View{
    
    @State var correo = ""
    @State var contraseña = ""
    @State var confirmarContraseña = ""
    
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
                
                Button {
                    tomarFoto()
                } label: {
                    Image("perfilEjemplo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 85, height: 85)
                        .overlay {
                            Image(systemName: "camera")
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom)
                }

                
            }
            
            VStack (alignment: .leading){
                
                Text("Correo electrónico*")
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
                
                Text("Contraseña*")
                    .foregroundStyle(.white)

                SecureField(text: $contraseña) {
                    Text("Escribe tu contraseña")
                        .font(.caption)
                        .foregroundColor(.gray)
                }.foregroundStyle(.white)
                
                Divider()
                    .frame(height: 1)
                    .background(.gray)
                    .padding(.bottom)
                
                Text("Confirmar Contraseña")
                    .foregroundStyle(.white)

                SecureField(text: $confirmarContraseña) {
                    Text("Vuelve a escribir tu contraseña")
                        .font(.caption)
                        .foregroundColor(.gray)
                }.foregroundStyle(.white)
                
                Divider()
                    .frame(height: 1)
                    .background(.gray)
                    .padding(.bottom)
                    
                Button {
                    registrarse()
                } label: {
                    Text("REGISTRATE")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 10)
                        .overlay(RoundedRectangle(cornerRadius: 6.0)
                            .stroke(Color("Dark-Cian"), lineWidth: 1.0)
                            .shadow(color: .white, radius: 6))
                }
                
                Text ("Inicia sesión con redes sociales")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 50)
                    .padding(.bottom)
                
                HStack (alignment: .center){
                    Button{
                        print("Facebook")
                    } label:{
                        Text("Facebook")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 150, height: 40)
                            .background(Color("Blue-Gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    Button{
                        print("Twitter")
                    } label:{
                        Text("Twitter")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 150, height: 40)
                            .background(Color("Blue-Gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }.frame(maxWidth: .infinity, alignment: .center)

            }
        }
    }
}

func registrarse(){
    
}

func tomarFoto() {
    print("Tomando foto...")
}

#Preview {
    ContentView()
}
