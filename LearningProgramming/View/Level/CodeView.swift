//
//  CodeView.swift
//  LearningProgramming
//
//  Created by Natanael  on 19/11/2021.
//

import SwiftUI

struct CodeView: View {
    var topicsArray: [TopicsArray]
    @Binding var languageType : LanguageType
    @EnvironmentObject var viewModel : LevelViewModel
    
    var body: some View {
        testView(topicsArray: topicsArray, languageType: languageType)
    }
}

struct testView : View {
    var topicsArray: [TopicsArray]
    var languageType : LanguageType
    @EnvironmentObject var viewModel : LevelViewModel
    var body : some View {
        switch (topicsArray.first!.topics[viewModel.passedTopics].taskType).self {
        case .explanation: return AnyView(ExplanationView(question: question(), numberOfLines: numberOfLines(), code: code()))
        case .abc: return AnyView(AbcView(question: question(), answers: topicsArray.first!.topics[viewModel.passedTopics].answers, correctAnswer: correctAnswer()))
            
        case .writeCode: return AnyView(WriteCodeView(code: code(), numberOfLines: numberOfLines()))
            
        case .writeAnswer: return AnyView(WriteAnswer(correctAnswer: correctAnswer(), numberOfLines: numberOfLines(), question: question(), code: code(), topic: topicsArray.first!.topics[viewModel.passedTopics]))
        }
    }
    func question() -> String {
        var array: [Topic] = []
        var question : String = ""
        if topicsArray.contains(where: { array = $0.topics; return $0.languageType == languageType}){
            question = array[viewModel.passedTopics].question
        }
        return question
    }
    func code() -> String {
        var array: [Topic] = []
        var code : String = ""
        if topicsArray.contains(where: { array = $0.topics; return $0.languageType == languageType}){
            code = array[viewModel.passedTopics].code
        }
        return code
    }
    func numberOfLines() -> Int {
        var array: [Topic] = []
        var numberOfLines : Int = 0
        if topicsArray.contains(where: { array = $0.topics; return $0.languageType == languageType}){
            numberOfLines = array[viewModel.passedTopics].numberOfLines
        }
        return numberOfLines
    }
    func correctAnswer() -> String {
        var array: [Topic] = []
        var correctAswer : String = ""
        if topicsArray.contains(where: { array = $0.topics; return $0.languageType == languageType}){
            correctAswer = array[viewModel.passedTopics].correctAnswer
        }
        return correctAswer
    }
    
}

struct WriteCodeView : View {
    var code: String
    var numberOfLines: Int
    var body: some View {
        VStack{
            ZStack{
                Color.ui.blue.ignoresSafeArea()
                    .cornerRadius(20, corners: [.topLeft, .bottomLeft])
                VStack(alignment:.leading){
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(alignment: .top){
                            VStack( alignment: .leading, spacing: 3){
                                ForEach((1 ... numberOfLines), id:\.self){ num in
                                    Text(String(num))
                                        .font(Font.custom("Menlo", size: 15))
                                        .foregroundColor(Color.ui.pastel)
                                }
                            }
                            Text(code)
                                .font(Font.custom("Menlo", size: 15))
                                .foregroundColor(Color.ui.pastel)
                            
                            Spacer()
                        }
                    }
                    .padding()
                }
            }.padding(.leading)
            Spacer()

        }
    }
}

struct AbcView : View {
    var question: String
    var answers: [Answer]
    var correctAnswer: String
    @State var id = ""
    @EnvironmentObject var viewModel : LevelViewModel
    var body: some View{
        VStack{
            Text(question)
                .font(Font.custom("Sofia Pro", size: 23))
                .foregroundColor(Color.ui.pastel)
                .multilineTextAlignment(.leading)
            VStack(spacing: 30){
                ForEach(answers){ answer in
                    Button {
                        withAnimation {
                            viewModel.didAnswered = true
                            id = answer.id ?? ""
                        }
                    } label: {
                        ZStack(alignment: .leading){
                            if viewModel.didAnswered && answer.text == correctAnswer {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 3)
                                    .fill(Color.ui.green)
                                    .frame(height: 100)
                            }
                            if viewModel.didAnswered && answer.text != correctAnswer && id == answer.id {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 3)
                                    .fill(Color.red)
                                    .frame(height: 100)
                            }
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.ui.blue)
                                .frame(height: 100)
                            Text(answer.text)
                                .font(Font.custom("Sofia Pro", size: 23))
                                .foregroundColor(Color.ui.pastel)
                                .padding()
                        }
                    }.disabled(viewModel.didAnswered)

                }
            }.padding(.top, 60)
            Spacer()
        }.padding()
            .padding(.bottom)
    }
}

struct ExplanationView : View {
    var question: String
    var numberOfLines: Int
    var code: String
    var body: some View {
        VStack {
            ZStack{
                Color.ui.blue.ignoresSafeArea()
                    .cornerRadius(20)
                ScrollView(showsIndicators: false){
                    VStack {
                        Text(question)
                            .foregroundColor(Color.ui.pastel)
                            .font(Font.custom("Sofia Pro", size: 23))
                        Spacer()
                    }.padding()
                        .padding(.top)
                }
            }.padding(.horizontal)
            ZStack{
                Color.ui.blue.ignoresSafeArea()
                    .cornerRadius(20, corners: [.topLeft, .bottomLeft])
                VStack(alignment:.leading){
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(alignment: .top){
                            VStack( alignment: .leading, spacing: 3){
                                ForEach((1 ... numberOfLines), id:\.self){ num in
                                    Text(String(num))
                                        .font(Font.custom("Menlo", size: 15))
                                        .foregroundColor(Color.ui.pastel)
                                }
                            }
                            Text(code)
                                .font(Font.custom("Menlo", size: 15))
                                .foregroundColor(Color.ui.pastel)
                            
                            Spacer()
                        }
                    }
                    .padding([.vertical, .leading])
                }
            }.padding(.leading)
                .padding(.top)

            Spacer()
        }
    }
}

struct WriteAnswer : View {
    var correctAnswer: String
    var numberOfLines: Int
    var question : String
    var code : String
    var topic: Topic
    @State var textInput = ""
    @State var wrongAnswer = false
    @EnvironmentObject var viewModel : LevelViewModel
    var placeholder = "Wpisz co powinno znajdować się w luce"
    var body: some View {
        VStack{
            Text(question)
                .padding()
                .font(Font.custom("Sofia Pro", size: 23))
                .foregroundColor(Color.ui.pastel)
                .multilineTextAlignment(.leading)
            ZStack{
                Color.ui.blue.ignoresSafeArea()
                
                    .cornerRadius(20)
                VStack(alignment:.leading){
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(alignment: .top){
                            VStack( alignment: .leading, spacing: 3){
                                ForEach((1 ... numberOfLines), id:\.self){ num in
                                    Text(String(num))
                                        .font(Font.custom("Menlo", size: 15))
                                        .foregroundColor(Color.ui.pastel)
                                }
                            }
                            changeText()
                                .font(Font.custom("Menlo", size: 15))
                                .foregroundColor(Color.white)
                            
                            Spacer()
                        }
                    }
                    .padding()
                }
            }.padding(.horizontal)
            Spacer()
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.ui.pastel)
                    if viewModel.didAnswered {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 3)
                            .fill(wrongAnswer ? Color.red : Color.ui.green)
                    }else{
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 3)
                            .fill(Color.ui.blue)
                    }
                    ZStack(alignment: .leading){
                        if textInput.isEmpty {
                            Text(placeholder)
                                .foregroundColor(Color.ui.blue.opacity(0.3))
                                .font(Font.custom("Sofia Pro", size: 18))
                        }
                        TextField("", text: $textInput)
                            .foregroundColor(Color.ui.blue)
                            .font(Font.custom("Sofia Pro", size: 18))
                            .textInputAutocapitalization(.never)
                    }
                        .padding(.leading)
                    
                }.frame(height: 50)
                
                if !textInput.isEmpty {
                    Button {
                        answer()
                    } label: {
                        ZStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.ui.blue)
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 3)
                                .fill(Color.ui.pastel)
                            Image(systemName: "arrow.right")
                                .foregroundColor(Color.ui.pastel)
                                .font(Font.custom("Sofia Pro", size: 18))
                        }.frame(width: 50, height: 50)
                    }

                }
            }.padding()
                .animation(.default)
                .padding(.bottom)
            Spacer()

        }
    }
    func changeText() -> Text{
        if code.contains("___________") && !textInput.isEmpty{
            var newText = Text("")
            newText = Text(code.replacingOccurrences(of: "___________", with: textInput))
            return newText
                
        }else{
            return Text(code)
        }
    }
    func answer() {
        withAnimation {
            viewModel.didAnswered = true
            if textInput == correctAnswer {
                UIApplication.shared.endEditing()
                wrongAnswer = false
            }else{
                wrongAnswer = true
            }
        }
    }
}

//struct CodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        WriteAnswer(mainText: "___________, \nsadasdasd ___________", numberOfLines: 9)
//    }
//}
