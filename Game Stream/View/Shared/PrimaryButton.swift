//
//  PrimaryButton.swift
//  Game Stream
//
//  Created by David Giron on 16/10/25.
//

import SwiftUI

struct PrimaryButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(title, action: action)
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.appSecondaryBackground, lineWidth: 1)
            .shadow(color: .white, radius: 6))
    }
}

#Preview {
    MainLayout{
        PrimaryButton(title: "Ejemplo"){}
    }
}
