//
//  GamesView.swift
//  Game Stream
//
//  Created by David Giron on 10/10/25.
//

import SwiftUI
import Kingfisher

struct GamesView: View {
    
    @ObservedObject var games: GamesViewModel
    @State var gameViewIsActive: Bool = false
    @State var url: String = ""
    @State var titulo: String = ""
    @State var studio: String = ""
    @State var calificacion: String = ""
    @State var anoPublicacion: String = ""
    @State var descripcion: String = ""
    @State var tags: [String] = [""]
    @State var imgsUrl: [String] = [""]
    
    let formaGrid = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack{
            Color.appPrimaryBackground.ignoresSafeArea()
            
            VStack{
                Text("Juegos")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                
                ScrollView{
                    LazyVGrid(columns: formaGrid, spacing: 8){
                        ForEach(games.gamesInfo, id: \.self) { game in
                            Button {
                                url = game.videosUrls.mobile
                                titulo = game.title
                                studio = game.studio
                                calificacion = game.contentRaiting
                                anoPublicacion = game.publicationYear
                                descripcion = game.description
                                tags = game.tags
                                imgsUrl = game.galleryImages
                                
                                gameViewIsActive = true
                            } label: {
                                // Usa la primera imagen de la galería, o la que corresponda
                                URLImage(urlString: game.galleryImages.first, cornerRadius: 4)
                                    .frame(height: 107)
                                    .scaledToFill()
                                    .padding(.bottom, 2)
                            }
                        }
                    }
                }
                
            }
            .padding(.horizontal, 6)
            .navigationDestination(isPresented: $gameViewIsActive) {
                /*GameView(url: url, titulo: titulo, studio: studio, calificacion: calificacion, anoPublicacion: anoPublicacion, descripcion: descripcion, tags: tags, imgsUrl: imgsUrl)*/
            }
        }
        .onAppear(
            perform: {
                if games.gamesInfo.indices.contains(0) {
                    print("Primer elemento del json: \(games.gamesInfo[0])")
                } else {
                    print("gamesInfo está vacío en este momento")
                    print("hola")
                }
            }
        )
    }
}

#Preview {
    GamesView(games: GamesViewModel())
}
