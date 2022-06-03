//
//  CustomTextField.swift
//  LearningProgramming
//
//  Created by Natanael  on 01/12/2021.
//

import SwiftUI

struct CustomTextField: View {
    
    let placeholder: Text
    let image: String
    
    @Binding var text: String
    
    var body: some View {
        HStack{
            Image(systemName: image)
                .padding(.horizontal)
                .font(.title)
                .foregroundColor(Color.ui.blue)
            ZStack(alignment: .leading){
                if text.isEmpty{
                    placeholder
                        .foregroundColor(Color.black.opacity(0.2))
                }
                TextField("", text: $text)
                
            }
            Spacer()
        }.padding()
            .background(
                Color.black.opacity(0.04)
                    .cornerRadius(20)
                    .frame(height: 90)
            )
    }
}


