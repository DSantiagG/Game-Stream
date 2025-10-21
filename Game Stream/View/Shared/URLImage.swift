//
//  CustomAsyncImage.swift
//  Game Stream
//
//  Created by David Giron on 20/10/25.
//

import SwiftUI

struct URLImage: View {
    var urlString: String?
    var cornerRadius: CGFloat = 0
    var contentMode: ContentMode = .fit

    var body: some View {
        if let urlString,
           let url = URL(string: urlString) {
            
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    // Mientras carga
                    ZStack {
                        Color.gray.opacity(0.2)
                        ProgressView()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius*3))
                    
                case .success(let image):
                    // Imagen cargada correctamente
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    
                case .failure:
                    // Si ocurre un error al cargar
                    ZStack {
                        Color.gray.opacity(0.2)
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius*3))
                    
                @unknown default:
                    EmptyView()
                }
            }
            
        } else {
            // Si no hay URL válida
            ZStack {
                Color.gray.opacity(0.2)
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.white.opacity(0.8))
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius*3))
        }
    }
}

#Preview {
    VStack {
        URLImage(urlString: "https://cdn.cloudflare.steamstatic.com/steam/apps/292030/header.jpg")
        //URLImage(urlString: nil)
    }
    .padding()
}
