//
//  GamesView.swift
//  Game Stream
//
//  Created by David Giron on 10/10/25.
//

import SwiftUI

struct GamesView: View {
    
    @ObservedObject var gamesVM: GamesViewModel
    
    @State private var isGameViewActive = false
    @State private var selectedGame: Game? = nil
    
    let gridForm = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        MainLayout{
            
            Text("Juegos")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(.white)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 40, trailing: 0))
            
            ScrollView{
                LazyVGrid(columns: gridForm, spacing: 8){
                    ForEach(gamesVM.gamesInfo, id: \.self) { game in
                        Button {
                            selectedGame = game
                            isGameViewActive = true
                        } label: {
                            URLImage(urlString: game.galleryImages[1], cornerRadius: 4)
                                .frame(height: 101)
                                .scaledToFill()
                                .padding(.bottom, 2)
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $isGameViewActive) {
            if let selectedGame{
                GameView(game: selectedGame)
            }
        }
    }
}

#Preview {
    GamesView(gamesVM: GamesViewModel())
}
