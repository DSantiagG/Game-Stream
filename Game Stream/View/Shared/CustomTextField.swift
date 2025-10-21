//
//  CustomTextField.swift
//  Game Stream
//
//  Created by David Giron on 16/10/25.
//

import SwiftUI

struct CustomTextField: View {
    
    var label: String
    var placeHolder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        
        let placeholder = Text(verbatim: placeHolder)
            .font(.caption)
            .foregroundColor(.gray)
        
        VStack(alignment: .leading){
            Text(label)
                .foregroundStyle(isSecure ? .white : Color.appSecondaryBackground)
            
            if isSecure {
                SecureField(text: $text) {placeholder}
                    .foregroundStyle(.white)
            }else{
                TextField(text: $text) {placeholder}
                    .foregroundStyle(.white)
            }
            
            Divider()
                .frame(height: 1)
                .background(isSecure ? .white : Color.appSecondaryBackground)
        }
    }
    
}

#Preview {
    struct Preview: View{
        @State var text: String = ""
        var body: some View{
            MainLayout{
                CustomTextField(label: "Correo electrónico", placeHolder: "ejemplo@gmail.com", text: $text)
                CustomTextField(label: "Contraseña", placeHolder: "Escribe tu contraseña", text: $text, isSecure: true)
            }
        }
    }
    return Preview()
}
