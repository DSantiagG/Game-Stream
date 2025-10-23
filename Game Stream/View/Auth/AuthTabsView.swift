//
//  AuthTabsView.swift
//  Game Stream
//
//  Created by David Giron on 16/10/25.
//

import SwiftUI

struct AuthTabsView: View {
    
    @State var isLogging = true
    
    var body: some View {
        MainLayout {
            Images.appLogo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
                .padding(.bottom, 34)
                .offset(x: 0, y: 4)
            
            HStack {
                Spacer()
                
                Button("INICIA SESIÓN"){
                    isLogging = true
                }
                .foregroundStyle(isLogging ? .white : .gray)
                .fontWeight(isLogging ? .bold : .regular)
                
                Spacer()
                
                Button("REGÍSTRATE"){
                    isLogging = false
                }
                .foregroundStyle(isLogging ? .gray : .white)
                .fontWeight(isLogging ? .regular : .bold)
                
                Spacer()
            }
            
            Spacer(minLength: 35)
            
            if isLogging {
                LoginView()
            } else {
                RegisterView()
            }
        }
    }
}

#Preview {
    AuthTabsView()
        .environmentObject(AuthViewModel())
}
