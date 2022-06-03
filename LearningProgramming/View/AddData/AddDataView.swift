//
//  AddDataView.swift
//  LearningProgramming
//
//  Created by Natanael  on 02/12/2021.
//

import SwiftUI

struct AddDataView: View {
    @Binding var isShown : Bool
    @State var languageType: LanguageType = .cpp
    @State var levelName = ""
    @State var lessonName = ""
    @State var lessonImage = ""
    @State var question1 = ""
    @State var question2 = ""
    @State var question3 = ""
    @State var code1 = ""
    @State var code2 = ""
    @State var code3 = ""
    @State var answer1 = ""
    @State var answer2 = ""
    @State var answer3 = ""
    @State var correctAnswer1 = ""
    @State var correctAnswer2 = ""
    @State var correctAnswer3 = ""
    @State var numberOfLines1 = 0
    @State var numberOfLines2 = 0
    @State var numberOfLines3 = 0
    @State var taskType1: TaskType = .explanation
    @State var taskType2: TaskType = .explanation
    @State var taskType3: TaskType = .explanation
    
    @EnvironmentObject var viewModel : LevelViewModel
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    isShown = false
                } label: {
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.ui.darkestBlue)
                }

                Spacer()
            }.edgesIgnoringSafeArea(.top)
            .padding()
            .padding(.top)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 40){
                    Text("Poziom trudności: ")
                        .font(Font.custom("Sofia Pro Bold", size: 35))
                        .foregroundColor(Color.ui.darkestBlue)
                    CustomAddDataTextField(placeholder: "Nazwa poziomu trudności", text: $levelName)
                    Text("Lekcja: ")
                        .font(Font.custom("Sofia Pro Bold", size: 35))
                        .foregroundColor(Color.ui.darkestBlue)
                    VStack(alignment: .leading, spacing: 60) {
                        CustomAddDataTextField(placeholder: "Nazwa lekcji", text: $lessonName)
                        CustomAddDataTextField(placeholder: "Zdjęcie lekcjii", text: $lessonImage)
                    }
                    Text("Tematy: ")
                        .font(Font.custom("Sofia Pro Bold", size: 35))
                        .foregroundColor(Color.ui.darkestBlue)
                    VStack(alignment: .leading, spacing: 60){
                        Text("Temat dla c++: ")
                            .font(Font.custom("Sofia Pro", size: 25))
                            .foregroundColor(Color.ui.darkestBlue)
    
                        Group{
                            CustomAddDataTextField(placeholder: "Pytanie", text: $question1)
                            CustomAddDataTextField(placeholder: "Kod", text: $code1)
                            CustomAddDataTextField(placeholder: "Odpowiedź", text: $answer1)
                            CustomAddDataTextField(placeholder: "Poprawna odpowiedź", text: $correctAnswer1)
                            NumberPicker(numberOfLines: $numberOfLines1)
                            TypePicker(type: $taskType1)
                        }
                        Text("Temat dla swift: ")
                            .font(Font.custom("Sofia Pro", size: 25))
                            .foregroundColor(Color.ui.darkestBlue)
                            
                        Group{
                            CustomAddDataTextField(placeholder: "Pytanie", text: $question2)
                            CustomAddDataTextField(placeholder: "Kod", text: $code2)
                            CustomAddDataTextField(placeholder: "Odpowiedź", text: $answer2)
                            CustomAddDataTextField(placeholder: "Poprawna odpowiedź", text: $correctAnswer2)
                            NumberPicker(numberOfLines: $numberOfLines2)
                            TypePicker(type: $taskType2)
                        }
                        
                        Text("Temat dla python: ")
                            .font(Font.custom("Sofia Pro", size: 25))
                            .foregroundColor(Color.ui.darkestBlue)
                            
                        Group{
                            CustomAddDataTextField(placeholder: "Pytanie", text: $question3)
                            CustomAddDataTextField(placeholder: "Kod", text: $code3)
                            CustomAddDataTextField(placeholder: "Odpowiedź", text: $answer3)
                            CustomAddDataTextField(placeholder: "Poprawna odpowiedź", text: $correctAnswer3)
                            NumberPicker(numberOfLines: $numberOfLines3)
                            TypePicker(type: $taskType3)
                        }

                        Button {
                            viewModel.addData(name: levelName, image: lessonImage, title: lessonName, answer1: answer1, code1: code1, correctAnswer1: correctAnswer1, numberOfLines1: numberOfLines1, question1: question1, taskType1: taskType1.rawValue, answer2: answer2, code2: code2, correctAnswer2: correctAnswer2, numberOfLines2: numberOfLines2, question2: question2, taskType2: taskType2.rawValue, answer3: answer3, code3: code3, correctAnswer3: correctAnswer3, numberOfLines3: numberOfLines3, question3: question3, taskType3: taskType3.rawValue, text: answer1)
                            isShown = false
                        } label: {
                            Text("przycisk")
                                .font(.title)
                        }

                        
                    }.padding(.leading)
                }.padding()
            }

            Spacer()
        }.background(Color.ui.pastel)
    }
}

//Level(lessons: [
//    Lesson(title: "", image: "", topicsArray: [
//        TopicsArray(topics: [
//            Topic(question: "", code: "", answers: [], correctAnswer: "", numberOfLines: 0, taskType: .writeCode)
//        ], languageType: .cpp)
//    ])
//], name: "")

