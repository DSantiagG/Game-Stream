//
//  AppTabsView.swift
//  Game Stream
//
//  Created by David Giron on 18/10/25.
//

import SwiftUI

struct AppTabsView: View {
    
    @StateObject private var gamesVM = GamesViewModel()
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack{
            TabView (selection: $selectedTab){
                HomeView(gamesVM: gamesVM)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Inicio")
                    }
                    .tag(0)
                
                GamesView(games: gamesVM)
                    .tabItem {
                        Image(systemName: "gamecontroller")
                        Text("Juegos")
                    }
                    .tag(1)
                
                FavoritesView()
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favoritos")
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Perfil")
                    }
                    .tag(3)
            }
            .tint(.white)
        }
    }
}

#Preview {
    AppTabsView()
}
