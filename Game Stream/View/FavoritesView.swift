//
//  FavoritesView.swift
//  Game Stream
//
//  Created by David Giron on 13/10/25.
//

import SwiftUI
import AVKit

struct FavoritesView: View {
    
    @ObservedObject var gamesVM: GamesViewModel
    
    var body: some View {
        
        MainLayout{
       
            Text("Tus Favoritos")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(.white)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 40, trailing: 0))
            
            ScrollView{
                ForEach(gamesVM.gamesInfo, id: \.self){ game in
                    VideoGameView(urlVideo: game.videosUrls.tablet, title: game.title)
                    .padding(.bottom)
                }
            }
        }
    }
}

struct VideoGameView: View{
    
    @State var urlVideo: String
    @State var title: String
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            
            CustomVideoPlayer(url: urlVideo)
            
            Text(title)
                .font(.headline.bold())
                .foregroundStyle(.white)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.appPrimaryButton)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    FavoritesView(gamesVM: GamesViewModel())
}
