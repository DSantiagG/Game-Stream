//
//  TemporalView.swift
//  Game Stream
//
//  Created by David Giron on 21/10/25.
//

import SwiftUI

struct TemporalView: View {
    var body: some View {
        MainLayout{
            VStack {
                HStack{
                    Image(systemName: "hammer")
                    Text("En Construcción...")
                }
                .font(.subheadline.bold())
                Text("Vuelve pronto 😉")
                    .font(.footnote)
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    TemporalView()
}
