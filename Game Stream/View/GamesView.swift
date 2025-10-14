//
//  GamesView.swift
//  Game Stream
//
//  Created by David Giron on 10/10/25.
//

import SwiftUI

struct GamesView: View {
    var body: some View {
        Text("Juegos")
            .font(.system(size: 30, weight: .bold))
            .onAppear(
                perform: {
                    print("Primer elemento del json:")
                    print("Titulo del primer videojuego del json")
                }
            )
    }
}

#Preview {
    GamesView()
}
