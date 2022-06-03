//
//  PickOption.swift
//  LearningProgramming
//
//  Created by Natanael  on 02/12/2021.
//

import SwiftUI

struct NumberPicker: View {
    @Binding var numberOfLines: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 40){
            Text("Wybierz ile ma być linii kodu: ")
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 3)
                    .fill(Color.ui.blue)
                Picker("Liczba linii kodu: ", selection: $numberOfLines){
                    ForEach(0 ..< 100){
                        Text("\($0) linii")
                    }
                }
            }.frame(height: 90)
        }.font(Font.custom("Sofia Pro", size: 25))
        .foregroundColor(Color.ui.blue)
        
    }
}

struct TypePicker: View {
    @Binding var type: TaskType
    var body: some View {
        VStack(alignment: .leading, spacing: 40){
            Text("Wybierz typ zadania: ")
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 3)
                    .fill(Color.ui.blue)
                Picker("Liczba linii kodu: ", selection: $type){
                    ForEach(TaskType.allCases, id:\.self){ task in
                        Text(task.name)
                    }
                }
            }.frame(height: 90)
        }.font(Font.custom("Sofia Pro", size: 25))
        .foregroundColor(Color.ui.blue)
        
    }
}
