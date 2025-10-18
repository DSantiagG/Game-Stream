//
//  GameView.swift
//  Game Stream
//
//  Created by David Giron on 10/10/25.
//

import SwiftUI
import AVKit

struct GameView: View {
    
    var url: String
    var titulo: String
    var studio: String
    var calificacion: String
    var anoPublicacion: String
    var descripcion: String
    var tags: [String]
    var imgsUrl: [String]
    
    var body: some View {
        ZStack{
            Color("Marine").ignoresSafeArea()
            VStack{
                Video(url: url)
                    .frame(height: 300)
                ScrollView{
                    VideoInfo(titulo: titulo, studio: studio, calificacion: calificacion, anoPublicacion: anoPublicacion, descripcion: descripcion, tags: tags)
                        .padding(.bottom, 16)
                    Gallery(imgsUrl: imgsUrl)
                        .padding(.bottom, 16)
                    Comments()
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct Video: View{
    var url: String
    var body: some View{
        VideoPlayer(player: AVPlayer(url: URL(string: url)!)).ignoresSafeArea()
    }
}

struct VideoInfo: View {
    var titulo: String
    var studio: String
    var calificacion: String
    var anoPublicacion: String
    var descripcion: String
    var tags: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(titulo)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            HStack(spacing: 16) {
                Text(studio)
                    .bold()
                Text(calificacion)
                Text(anoPublicacion)
            }
            .font(.subheadline)
            .foregroundStyle(.gray)

            Text(descripcion)
                .font(.body)
                .foregroundStyle(.white)

            if !tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(tags, id: \.self) { tag in
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
        .padding(.horizontal)
    }
}

struct Gallery: View{
    var imgsUrl: [String]
    let formaGrid = [GridItem(.flexible())]
    var body: some View{
        VStack (alignment: .leading, spacing: 15){
            Text("GALERÍA")
                .foregroundStyle(.white)
                .font(.title2.bold())
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: formaGrid, spacing: 8){
                    ForEach(imgsUrl, id: \.self) { url in
                        if let url = URL(string: url) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ZStack {
                                        Color.gray.opacity(0.2)
                                        ProgressView()
                                    }
                                    .frame(width: 280)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))

                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(RoundedRectangle.init(cornerRadius: 4))

                                case .failure:
                                    ZStack {
                                        Color.gray.opacity(0.2)
                                        Image(systemName: "photo")
                                            .font(.largeTitle)
                                            .foregroundStyle(.white.opacity(0.8))
                                    }
                                    .frame(width: 280)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))

                                @unknown default:
                                    EmptyView()
                                }
                            }

                        } else {
                            ZStack {
                                Color.gray.opacity(0.2)
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                            .frame(width: 280)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
            }
            .frame(height: 180)
        }
        .padding(.horizontal)
    }
}

struct Comments: View {
    var body: some View{
        VStack (alignment: .leading, spacing: 15){
            Text("COMENTARIOS")
                .foregroundStyle(.white)
                .font(.title2.bold())
            
            ScrollView(showsIndicators: false){
                
                    Comment(name: "Geoff Atto", img: "profile-picture", date: "Hace 7 días", text: "He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.")
                    
                    Comment(name: "Alvy Baack", img: "profile-picture-2", date: "Hace 12 días", text: "He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.")
                    
                    Comment(name: "Geoff Atto", img: "profile-picture", date: "Hace 7 días", text: "He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.")
    
            }
            .frame(height: 300)
        }
        .padding(.horizontal)
    }
}

struct Comment: View {
    var name: String
    var img: String
    var date: String
    var text: String
    var body: some View {
        VStack (alignment: .leading, spacing: 12){
            HStack (spacing: 10){
                Image(img)
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
                .fill(Color("Blue-Gray"))
        }
    }
}

#Preview {
    GameView(url: "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4", titulo: "Sonic", studio: "Sega", calificacion: "E+", anoPublicacion: "1991", descripcion: "Mi juego", tags: ["Plataformas", "Aventura", "Acción"], imgsUrl: ["https://cdn.cloudflare.steamstatic.com/steam/apps/292030/ss_107600c1337accc09104f7a8aa7f275f23cad096.600x338.jpg", "https://cdn.cloudflare.steamstatic.com/steam/apps/292030/ss_107600c1337accc09104f7a8aa7f275f23cad096.600x338.jpg", "https://cn.cloudflare.steamstatic.com/steam/apps/292030/ss_107600c1337accc09104f7a8aa7f275f23cad096.600x338.jpg"])
}
