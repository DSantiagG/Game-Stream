//
//  RootView.swift
//  Game Stream
//
//  Created by David Giron on 16/10/25.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
            ZStack {
                if auth.isLoggedIn {
                    AppTabsView()
                        .transition(.move(edge: .trailing))
                } else {
                    AuthTabsView()
                        .transition(.move(edge: .leading))
                }
            }
            .animation(.easeInOut, value: auth.isLoggedIn)
        }
}

#Preview {
    RootView()
        .environmentObject(AuthViewModel())
}
