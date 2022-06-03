//
//  CustomAddDataTextField.swift
//  LearningProgramming
//
//  Created by Natanael  on 02/12/2021.
//

import SwiftUI

struct CustomAddDataTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack{
            ZStack(alignment: .leading){
                if text.isEmpty{
                    Text(placeholder)
                        .font(Font.custom("Sofia Pro Bold", size: 15))
                        .foregroundColor(Color.black.opacity(0.2))
                }
                TextField("", text: $text)
                
            }
            Spacer()
        }.padding()
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 3)
                        .fill(Color.ui.blue)
                }.frame(height: 90)
            )
    }
}

