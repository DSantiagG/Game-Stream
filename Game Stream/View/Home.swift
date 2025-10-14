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
                
                Text("Perfil")
                    .font(.system(size: 30, weight: .bold))
                .tabItem {
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
                
                Text("Favoritos")
                    .font(.system(size: 30, weight: .bold))
                    .tabItem {
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
    
    @State var textoBusqueda = ""
    var body: some View{
        ZStack {
            
            Color("Marine").ignoresSafeArea()
            VStack {
                Image("appLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                //.padding(.bottom, 40)
                    .padding(.horizontal, 11)
                
                HStack{
                    Button {
                        buscar()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(textoBusqueda.isEmpty ? .yellow : Color("Dark-Cian"))
                    }
                    
                    TextField(text: $textoBusqueda) {
                        Text("Buscar un video")
                            .foregroundStyle(Color(red: 174/255, green: 177/255, blue: 185/255))
                    }
                    .foregroundStyle(.white)
                }
                .padding([.top, .leading, .bottom], 11.0)
                .background(Color("Blue-Gray"))
                .clipShape(Capsule())
                
                ScrollView{
                    SubModuleHome()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
        }
    
    }
    func buscar() {
        print("El usuario esta buscando \(textoBusqueda)")
    }
}

struct SubModuleHome: View {
    
    @State var url = "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4"
    @State var isPlayerActive = false
    let urlVideos: [String] = ["https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4", "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4", "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4", "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4", "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4", "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4", "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4"]
    
    var body: some View{
        VStack{
            Text("LOS MÁS POPULARES")
                .font(.title3)
                .foregroundStyle(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            ZStack{
                
                Button {
                    url = urlVideos[0]
                    print("URL: \(url)")
                    isPlayerActive = true
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
            
            Text("RECOMENDADOS PARA TI")
                .font(.title3)
                .foregroundStyle(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            ScrollView (.horizontal, showsIndicators: false){
                HStack{
                    
                    Button {
                        url = urlVideos[1]
                        print("URL: \(url)")
                        isPlayerActive = true
                    } label: {
                        Image("Abzu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button {
                        url = urlVideos[2]
                        print("URL: \(url)")
                        isPlayerActive = true
                    } label: {
                        Image("Crash Bandicoot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button {
                        url = urlVideos[3]
                        print("URL: \(url)")
                        isPlayerActive = true
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
                        url = urlVideos[1]
                        print("URL: \(url)")
                        isPlayerActive = true
                    } label: {
                        Image("Abzu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button {
                        url = urlVideos[2]
                        print("URL: \(url)")
                        isPlayerActive = true
                    } label: {
                        Image("Crash Bandicoot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button {
                        url = urlVideos[3]
                        print("URL: \(url)")
                        isPlayerActive = true
                    } label: {
                        Image("DEATH STRANDING")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                }
            }
            
        }
        .navigationDestination(isPresented: $isPlayerActive) {
            VideoPlayer(player: AVPlayer(url: URL(string: url)!))
                .frame(width: 400, height: 300)
        }
    }
}

#Preview {
    Home()
}
