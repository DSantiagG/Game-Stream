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
    var playInOverlay: Bool = false
    
    @State private var showOverlayPlayer = false
    @State private var isPlaying = false
    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            if isPlaying, let player, !playInOverlay {
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
                        .clipped()
                    }
                    else if let posterImage {
                        posterImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
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
            configureAudioSession()
            if player == nil {
                player = AVPlayer(url: URL(string: url)!)
            }
        }
        .onDisappear {
            player?.pause()
            player?.seek(to: .zero)
            isPlaying = false
        }
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error configurando AVAudioSession: \(error)")
        }
    }
    
    private func startVideo() {
        if playInOverlay {
            VideoOverlayPresenter.shared.showVideo(url: url)
        } else {
            isPlaying = true
        }
    }
}

#Preview {
    MainLayout {
        CustomVideoPlayer(
            url: "https://dl.dropboxusercontent.com/s/k6g0zwmsxt9qery/TheWitcher480.mp4",
            posterURL: "https://cdn.cloudflare.steamstatic.com/steam/apps/292030/header.jpg",
            playInOverlay: true
        )
        .frame(maxHeight: 200)
        .scaledToFit()
    }
}
