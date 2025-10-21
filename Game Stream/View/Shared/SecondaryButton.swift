//
//  SocialButton.swift
//  Game Stream
//
//  Created by David Giron on 16/10/25.
//

import SwiftUI

struct SecondaryButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(width: 150, height: 40)
            .background(Color.appPrimaryButton)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MainLayout{
        SecondaryButton(title: "Facebook"){}
    }
}
