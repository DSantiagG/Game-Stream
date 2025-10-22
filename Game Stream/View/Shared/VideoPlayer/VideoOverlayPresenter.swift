//
//  VideoOverlayPresenter.swift
//  Game Stream
//
//  Created by David Giron on 21/10/25.
//


import SwiftUI
import AVKit

// MARK: - Presentador UIKit (permite overlays encima de todo)
final class VideoOverlayPresenter {
    static let shared = VideoOverlayPresenter()
    
    private var overlayWindow: UIWindow?
    
    func showVideo(url: String) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let videoURL = URL(string: url) else { return }

        let player = AVPlayer(url: videoURL)
        let controller = UIHostingController(rootView: VideoOverlayView(player: player, dismissAction: dismiss))
        controller.view.backgroundColor = .clear

        let window = UIWindow(windowScene: scene)
        window.rootViewController = controller
        window.windowLevel = .alert + 1
        window.backgroundColor = .clear
        window.isHidden = false

        window.isOpaque = false

        window.makeKeyAndVisible()
        self.overlayWindow = window
    }
    
    private func dismiss() {
        overlayWindow?.isHidden = true
        overlayWindow = nil
    }
}

// MARK: - Vista SwiftUI que se muestra en el overlay
struct VideoOverlayView: View {
    
    @State var player: AVPlayer
    var dismissAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissAction()
                }
            VStack {
                Button(action: dismissAction) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.white)
                        .padding(.trailing, 30)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Spacer()
                VideoPlayer(player: player)
                    .aspectRatio(16/9, contentMode: .fit)
                    .cornerRadius(12)
                    .shadow(radius: 20)
                    .onAppear {
                        player.play()
                    }
                Spacer()
            }
        }
    }
}
