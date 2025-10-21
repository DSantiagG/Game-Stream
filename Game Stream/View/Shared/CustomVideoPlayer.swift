//
//  CustomVideoPlayer.swift
//  Game Stream
//
//  Created by David Giron on 20/10/25.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: View {
    
    var url: String
    var posterImage: Image? = nil         
    var posterURL: String? = nil
    
    @State private var isPlaying = false
    @State private var player: AVPlayer?
    
    var body: some View {
        ZStack {
            if isPlaying, let player {
                VideoPlayer(player: player)
                    .aspectRatio(16/9, contentMode: .fill)
                    .onAppear {
                        player.play()
                    }
            } else {
                ZStack {
                    if let posterURL{
                        URLImage(urlString: posterURL,
                                 contentMode: .fill)
                    }
                    else if let posterImage {
                        posterImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }else{
                        VideoPlayer(player: player)
                            .aspectRatio(16/9, contentMode: .fill)
                    }
                    
                    Button(action: startVideo) {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.white)
                            .shadow(radius: 8)
                    }
                }
            }
        }
        .onAppear {
            // Permitir sonido aunque el teléfono esté en modo silencio
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Error configurando AVAudioSession: \(error)")
            }
            
            if player == nil {
                player = AVPlayer(url: URL(string: url)!)
            }
        }
    }
    
    func startVideo() {
        isPlaying = true
        player?.play()
    }
}

#Preview {
    MainLayout {
        CustomVideoPlayer(
            url: "https://dl.dropboxusercontent.com/s/k6g0zwmsxt9qery/TheWitcher480.mp4",
            posterURL: "https://cdn.cloudflare.steamstatic.com/steam/apps/292030/header.jpg"
        )
        .frame(maxHeight: 200)
        .scaledToFit()
    }
}
