//
//  FavoritesView.swift
//  Game Stream
//
//  Created by David Giron on 13/10/25.
//

import SwiftUI
import AVKit

struct FavoritesView: View {
    @ObservedObject var todosLosVideoJuegos = GamesViewModel()
    
    var body: some View {
        ZStack{
            Color.appPrimaryBackground
                .ignoresSafeArea()
            VStack{
                Text("FAVORITOS")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .padding(.bottom, 9.0)
                ScrollView{
                    ForEach(todosLosVideoJuegos.gamesInfo, id: \.self){
                        game in
                        
                        VStack(alignment: .leading, spacing: 0){
                            
                            VideoPlayer(player: AVPlayer(url: URL(string: game.videosUrls.mobile)!))
                                .frame(height: 210)
                            
                            Text(game.title)
                                .font(.headline.bold())
                                .foregroundStyle(.white)
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.appPrimaryButton)
                                .clipShape(RoundedRectangle(cornerRadius: 3.0))
                                .padding(.bottom)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    FavoritesView()
}
