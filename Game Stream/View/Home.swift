//
//  Home.swift
//  Game Stream
//
//  Created by David Giron on 9/10/25.
//

import SwiftUI
import AVKit

struct Home: View {
    
    @State var selectedTab: Int = 2
    
    var body: some View {
            
            TabView (selection: $selectedTab){
                
                ProfileView().tabItem {
                    Image(systemName: "person")
                    Text("Perfil")
                }
                .tag(0)
                
                GamesView()
                    .tabItem {
                        Image(systemName: "gamecontroller")
                        Text("Juegos")
                    }
                    .tag(1)
                
                HomeTabView().tabItem {
                        Image(systemName: "house")
                        Text("Inicio")
                    }
                    .tag(2)
                
                FavoritesView().tabItem {
                        Image(systemName: "heart")
                        Text("Favoritos")
                    }
                    .tag(3)
            }
            .tint(.white)
            .toolbar(.hidden)
    }
    
    init() {
        /*let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(Color("TabBar-Color"))
        */
        print("Iniciando las vistas de Home")
    }
}

struct HomeTabView: View {
    
    var body: some View{
        ZStack {
            
            Color("Marine").ignoresSafeArea()
            VStack {
                Image("appLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 11)
                
                ScrollView{
                    SubModuleHome()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
        }
    
    }
}

struct SubModuleHome: View {
    
    @State var isGameInfoEmpy = false
    
    @State var textoBusqueda = ""
    
    @ObservedObject var juegoEncontrado = SearchGameViewModel()
    @State var isGameViewActive = false
    
    @State var url: String = ""
    @State var titulo: String = ""
    @State var studio: String = ""
    @State var calificacion: String = ""
    @State var anoPublicacion: String = ""
    @State var descripcion: String = ""
    @State var tags: [String] = [""]
    @State var imgsUrl: [String] = [""]
    
    var device = UIDevice.current.model
    
    var body: some View{
        VStack{
            
            HStack{
                Button (action: {
                    watchGame(name: textoBusqueda)
                    
                    
                } ,label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(textoBusqueda.isEmpty ? .yellow : Color("Dark-Cian"))
                })
                .alert(
                    "Error",
                    isPresented: $isGameInfoEmpy,
                    actions: {
                        Button("Entendido", role: .cancel) { }
                    },
                    message: {
                        Text("No se encontro el juego")
                    }
                )
                
                TextField(text: $textoBusqueda) {
                    Text("Buscar un video")
                        .foregroundStyle(Color(red: 174/255, green: 177/255, blue: 185/255))
                }
                .foregroundStyle(.white)
            }
            .padding([.top, .leading, .bottom], 11.0)
            .background(Color("Blue-Gray"))
            .clipShape(Capsule())
            
            Text("LOS MÁS POPULARES")
                .font(.title3)
                .foregroundStyle(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            ZStack{
                
                Button {
                    watchGame(name: "The Witcher 3")
                } label: {
                    VStack (spacing: 0){
                        Image("The Witcher 3")
                            .resizable()
                            .scaledToFit()
                        
                        Text("The Witcher 3")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .bold()
                            .padding()
                            .background(Color("Blue-Gray"))
                    }
                }
                
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 42, height: 42)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.vertical)
            
            Text("CATEGORÍAS SUGERIDAS PARA TI")
                .font(.title3)
                .foregroundStyle(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            ScrollView (.horizontal, showsIndicators: false){
                
                if(device == "iPad"){
                    HStack{
                        
                        Button {
                            print("FPS")
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Blue-Gray"))
                                    .frame(width: 320, height: 180)
                                Image("FPS")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 84, height: 84)
                            }
                        }
                        
                        Button {
                            print("RPG")
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Blue-Gray"))
                                    .frame(width: 320, height: 180)
                                Image("RPG")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 84, height: 84)
                            }
                        }
                        
                        Button {
                            print("OpenWorld")
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Blue-Gray"))
                                    .frame(width: 320, height: 180)
                                Image("OpenWorld")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
                }else{
                    HStack{
                        
                        Button {
                            print("FPS")
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Blue-Gray"))
                                    .frame(width: 160, height: 90)
                                Image("FPS")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                            }
                        }
                        
                        Button {
                            print("RPG")
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Blue-Gray"))
                                    .frame(width: 160, height: 90)
                                Image("RPG")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                            }
                        }
                        
                        Button {
                            print("OpenWorld")
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Blue-Gray"))
                                    .frame(width: 160, height: 90)
                                Image("OpenWorld")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                            }
                        }
                    }
                }
            }
            
            Text("RECOMENDADOS PARA TI")
                .font(.title3)
                .foregroundStyle(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            ScrollView (.horizontal, showsIndicators: false){
                HStack{
                    
                    Button {
                        watchGame(name: "Abzu")
                    } label: {
                        Image("Abzu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button {
                        watchGame(name: "Crash Bandicoot")
                    } label: {
                        Image("Crash Bandicoot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button {
                        watchGame(name: "DEATH STRANDING")
                    } label: {
                        Image("DEATH STRANDING")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                }
            }
            
            Text("VIDEOS QUE PODRÍAN GUSTARTE")
                .font(.title3)
                .foregroundStyle(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            ScrollView (.horizontal, showsIndicators: false){
                HStack{
                    
                    Button {
                        watchGame(name: "Cuphead")
                    } label: {
                        Image("Cuphead")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button {
                        watchGame(name: "Hades")
                    } label: {
                        Image("Hades")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button {
                        watchGame(name: "Grand Theft Auto")
                    } label: {
                        Image("Grand Theft Auto")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                }
            }
            
        }
        .navigationDestination(isPresented: $isGameViewActive) {
            GameView(url: url, titulo: titulo, studio: studio, calificacion: calificacion, anoPublicacion: anoPublicacion, descripcion: descripcion, tags: tags, imgsUrl: imgsUrl)
        }
    }
    
    func watchGame(name: String) {
        juegoEncontrado.search(gameName: name)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            print("Cantidad E: \(juegoEncontrado.gameInfo.count)")
            if juegoEncontrado.gameInfo.count == 0 {
                isGameInfoEmpy = true
            }else{
                url = juegoEncontrado.gameInfo[0].videosUrls.mobile
                titulo = juegoEncontrado.gameInfo[0].title
                studio = juegoEncontrado.gameInfo[0].studio
                calificacion = juegoEncontrado.gameInfo[0].contentRaiting
                anoPublicacion = juegoEncontrado.gameInfo[0].publicationYear
                descripcion = juegoEncontrado.gameInfo[0].description
                tags = juegoEncontrado.gameInfo[0].tags
                imgsUrl = juegoEncontrado.gameInfo[0].galleryImages
                
                isGameViewActive = true
            }
        }
    }
    
}

#Preview {
    Home()
}
