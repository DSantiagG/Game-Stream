//
//  Home.swift
//  Game Stream
//
//  Created by David Giron on 9/10/25.
//

import SwiftUI
import AVKit

struct HomeView: View {
    
    @ObservedObject var gamesVM: GamesViewModel
    
    var body: some View{
        let recomendedGames = gamesVM.gamesInfo.dropFirst(1).prefix(3)
        let suggestedGames = gamesVM.gamesInfo.dropFirst(4)
        
        MainLayout {
            Images.appLogo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
                .padding(.bottom, 20)
                .padding(.horizontal, 11)
            
            ScrollView{
                SearchModule()
                    .padding(.bottom)
                
                VStack (spacing: 30){
                    if let game = gamesVM.gamesInfo.first{
                        PopularsModule(game: game)
                    }
                    CategoriesModule()
                    SubModule(title: "RECOMENDADOS PARA TI", games: Array(recomendedGames))
                    SubModule(title: "JUEGOS QUE PODRÍAN GUSTARTE", games: Array(suggestedGames))
                }
                
            }
        }
    }
}

struct SearchModule: View{
    
    @State private var showGameNotFoundAlert = false
    @State private var isGameViewActive = false
    @State private var searchText = ""
    @State private var selectedGame: Game? = nil
    
    @ObservedObject var searchGameVM = SearchGameViewModel()
    
    var body: some View {
        HStack{
            Button(action: { searchGame(name: searchText) }) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(searchText.isEmpty ? .yellow : Color.appSecondaryBackground)
            }
            .alert(
                "Error", isPresented: $showGameNotFoundAlert,
                actions: {
                    Button("Entendido", role: .cancel) { }
                },
                message: {
                    Text("No se encontro el juego")
                }
            )
            TextField(text: $searchText) {
                Text("Buscar un video")
                    .foregroundStyle(Color(red: 174/255, green: 177/255, blue: 185/255))
            }
            .foregroundStyle(.white)
        }
        .padding([.top, .leading, .bottom], 11.0)
        .background(Color.appPrimaryButton)
        .clipShape(Capsule())
        .navigationDestination(isPresented: $isGameViewActive) {
            if let selectedGame{
                GameView(game: selectedGame)
            }
        }
    }
    
    func searchGame(name: String) {
        searchGameVM.search(gameName: name)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            if searchGameVM.gamesFound.count == 0 {
                showGameNotFoundAlert = true
            }else{
                selectedGame = searchGameVM.gamesFound.first
                isGameViewActive = true
            }
        }
    }
}

struct PopularsModule: View {
    
    var game: Game
    
    var body: some View {
        VStack{
            Text("LOS MÁS POPULARES")
                .font(.title3.bold())
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            
            VStack (spacing: 0){
                CustomVideoPlayer(
                    url: game.videosUrls.tablet,
                    posterURL: game.galleryImages[0]
                )
                .frame(maxHeight: 200)
                .scaledToFit()
                
                Text("The Witcher 3")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.appPrimaryButton)
            }
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}

struct CategoriesModule: View {
    
    let categories: [(name: String, image: Image)] = [
        ("FPS", Images.Home.fpsIcon),
        ("RPG", Images.Home.rpgIcon),
        ("OpenWorld", Images.Home.openWorldIcon)
    ]
    let device = UIDevice.current.model
    
    var body: some View{
        VStack{
            Text("CATEGORÍAS SUGERIDAS PARA TI")
                .font(.title3.bold())
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView (.horizontal, showsIndicators: false){
                HStack {
                    if(device == "iPad"){
                        ForEach(Array(categories.enumerated()), id: \.offset) { _, item in
                            Button {
                                print(item.name)
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.appPrimaryButton)
                                        .frame(width: 320, height: 180)
                                    item.image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 84, height: 84)
                                }
                            }
                        }
                    }else{
                        ForEach(Array(categories.enumerated()), id: \.offset) { _, item in
                            Button {
                                print(item.name)
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.appPrimaryButton)
                                        .frame(width: 160, height: 90)
                                    item.image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SubModule: View {
    
    @State var title: String
    var games: [Game]
    
    @State private var isGameViewActive = false
    @State private var selectedGame: Game? = nil
    
    var body: some View{
        VStack{
            Text(title)
                .font(.title3.bold())
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(games, id: \.self) { game in
                        Button {
                            selectedGame = game
                            isGameViewActive = true
                        } label: {
                            VStack(alignment: .leading, spacing: 0) {
                                URLImage(urlString: game.galleryImages.first)
                                    .scaledToFill()
                                    .frame(width: 240, height: 135)
                                    .clipped()
                                Text(game.title)
                                    .font(.subheadline.bold())
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.appPrimaryButton)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isGameViewActive) {
                if let selectedGame {
                    GameView(game: selectedGame)
                }
            }
        }
    }
}

#Preview {
    HomeView(gamesVM: GamesViewModel())
}
