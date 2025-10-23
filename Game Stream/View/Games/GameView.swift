//
//  GameView.swift
//  Game Stream
//
//  Created by David Giron on 10/10/25.
//

import SwiftUI

struct GameView: View {
    
    var game: Game
    
    var body: some View {
        ZStack{
            Color.appPrimaryBackground
                .ignoresSafeArea()
            
            ScrollView (showsIndicators: false){
                GeometryReader { geo in
                    CustomVideoPlayer(
                        url: game.videosUrls.mobile,
                        posterURL: game.galleryImages[2],
                        playInOverlay: true
                    )
                    .frame(width: geo.size.width, height: 470)
                }
                .frame(height: 400)
                
                MainLayout{
                    VStack(spacing: 16) {
                        GameInfo(game: game)
                        Gallery(imgsUrl: game.galleryImages)
                        Comments()
                            .padding(.bottom, 30)
                    }.padding(.top)
                }
            }
            .ignoresSafeArea()
            
            
        }
    }
}

struct GameInfo: View {
    
    var game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(game.title)
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
            
            HStack(spacing: 16) {
                Text(game.studio)
                    .bold()
                Text(game.contentRaiting)
                Text(game.publicationYear)
            }
            .font(.subheadline)
            .foregroundStyle(.gray)
            
            if !game.platforms.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(game.platforms, id: \.self) { tag in
                            VStack (spacing: 1){
                                Text("\(tag)")
                                    .font(.caption)
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 3)
                                    .foregroundStyle(.white)
                                Divider()
                                    .frame(height: 1)
                                    .background(Color.appSecondaryBackground)
                            }
                        }
                    }
                }
            }
            
            Text(game.description)
                .font(.body)
                .foregroundStyle(.white)
            
            if !game.tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(game.tags, id: \.self) { tag in
                            Text("#\(tag)")
                                .font(.caption)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white.opacity(0.15))
                                )
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
    }
}

struct Gallery: View{
    
    var imgsUrl: [String]
    let gridForm = [GridItem(.flexible())]
    
    var body: some View{
        VStack (alignment: .leading, spacing: 12){
            Text("GALERÍA")
                .font(.title2.bold())
                .foregroundStyle(.white)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: gridForm, spacing: 8){
                    ForEach(imgsUrl, id: \.self) { url in
                        URLImage(urlString: url, cornerRadius: 4, contentMode: .fill)
                            .frame(width: 320)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .frame(height: 180)
        }
    }
}

struct Comments: View {
    var body: some View{
        VStack (alignment: .leading, spacing: 12){
            Text("COMENTARIOS")
                .foregroundStyle(.white)
                .font(.title2.bold())
            
            ScrollView(showsIndicators: false){
                ForEach(0..<3) { _ in
                    Comment( name: "Geoff Atto", image: Images.Placeholder.userPlaceholder1, date: "Hace 7 días", text: "He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades."
                    )
                }
            }
            .frame(height: 400)
        }
    }
}

struct Comment: View {
    var name: String
    var image: Image
    var date: String
    var text: String
    var body: some View {
        
        VStack (alignment: .leading, spacing: 12){
            HStack (spacing: 10){
                image
                    .resizable()
                    .frame(width: 45, height: 45)
                
                VStack (alignment: .leading){
                    Text(name)
                        .bold()
                    Text(date)
                        .font(.footnote)
                }
            }
            Text(text)
                .font(.system(size: 15, weight: .regular, design: .default))
        }
        .foregroundStyle(.white)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.appPrimaryButton)
        }
    }
}

#Preview {
    GameView(game: Game(title: "Sonic", studio: "Sega", contentRaiting: "E+", publicationYear: "1991", description: "Mi juego", platforms: ["Xbox", "Play"], tags: ["Plataformas", "Aventura", "Acción"], videosUrls: VideoURL(mobile: "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4", tablet: "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4"), galleryImages: ["https://cdn.cloudflare.steamstatic.com/steam/apps/292030/ss_107600c1337accc09104f7a8aa7f275f23cad096.600x338.jpg", "https://cdn.cloudflare.steamstatic.com/steam/apps/292030/ss_107600c1337accc09104f7a8aa7f275f23cad096.600x338.jpg", "https://cdn.cloudflare.steamstatic.com/steam/apps/292030/ss_107600c1337accc09104f7a8aa7f275f23cad096.600x338.jpg"]))
}
