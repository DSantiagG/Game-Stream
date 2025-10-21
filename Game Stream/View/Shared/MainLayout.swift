//
//  MainLayout.swift
//  Game Stream
//
//  Created by David Giron on 16/10/25.
//

import SwiftUI

struct MainLayout<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.appPrimaryBackground.ignoresSafeArea()
            VStack {
                content
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MainLayout{
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
