//
//  LessonView.swift
//  LearningProgramming
//
//  Created by Natanael  on 19/11/2021.
//

import SwiftUI

struct LessonView: View {
    let lesson: Lesson
    let topicsArray: [TopicsArray]
    @State var languageType: LanguageType = .cpp
    
    @EnvironmentObject var viewModel : LevelViewModel
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        ZStack{
            Color.ui.darkestBlue
                .frame(height: screenH)
                .ignoresSafeArea()
            VStack{
                HStack{
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        ZStack{
                            Color.ui.blue
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.ui.pastel)
                                .font(Font.custom("Sofia Pro Bold", size: 20))
                        }
                        
                    }
                    Spacer()
                }.padding(.top, 40)
                    .padding(.leading)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        if !(lesson.topicsArray.first!.topics[viewModel.passedTopics].taskType == .abc && lesson.topicsArray.first!.topics[viewModel.passedTopics].taskType == .writeAnswer){
                            ScrollView(.horizontal){
                                HStack(spacing: 10){
                                    ForEach(LanguageType.allCases, id:\.self){ lang in
                                        Button {
                                            withAnimation {
                                                switch (lang){
                                                case .cpp: return languageType = .cpp
                                                case .swift: return languageType = .swift
                                                case .python: return languageType = .python
                                                }
                                            }
                                        } label: {
                                            ZStack{
                                                Color.ui.blue
                                                    .cornerRadius(5)
                                                Text(lang.name)
                                                    .font(lang == languageType ? Font.custom("Sofia Pro Bold", size: 22) : Font.custom("Sofia Pro ExtraLight", size: 18))
                                                    .foregroundColor(lang == languageType ? .white : .ui.pastel)
                                            }
                                        }.frame(width: 150, height: 50)
                                    }
                                }
                            }.padding()
                        }
                        CodeView(topicsArray: topicsArray, languageType: $languageType)
                    }
                }
                Spacer()
                HStack(spacing: 10){
                    if viewModel.passedTopics+1 != 1{
                        Button {
                            if viewModel.passedTopics > 0 {
                                withAnimation {
                                    viewModel.didAnswered = false
                                    viewModel.passedTopics -= 1
                                    UserDefaults.standard.set(viewModel.passedTopics, forKey: "passedTopics")
                                }
                            }
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).fill(Color.ui.blue)
                                Text("Wstecz")
                                    .font(Font.custom("Sofia Pro Bold", size: 20))
                                    .foregroundColor(Color.ui.pastel)
                            }
                        }.frame(height: 50)
                    }
                    ZStack{
                        Color.ui.darkBlue
                        HStack{
                            Text(String(viewModel.passedTopics+1)).foregroundColor(Color.white)
                            Text("/").foregroundColor(Color.white)
                            Text(String("\(topicsArray.first!.topics.count)")).foregroundColor(Color.ui.pastel)
                        }.font(Font.custom("Sofia Pro Bold", size: 20))
                    }.cornerRadius(20)
                        .frame(height: 50)
                    
                    if viewModel.didAnswered || (lesson.topicsArray.first!.topics[viewModel.passedTopics].taskType != .abc && lesson.topicsArray.first!.topics[viewModel.passedTopics].taskType != .writeAnswer){
                        if viewModel.passedTopics+1 < lesson.topicsArray.first!.topics.count {
                            Button {
                                if viewModel.passedTopics < lesson.topicsArray.first!.topics.count {
                                    withAnimation {
                                        viewModel.didAnswered = false
                                        viewModel.passedTopics += 1
                                    }
                                }
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20).fill(Color.ui.blue)
                                    Text("Dalej")
                                        .font(Font.custom("Sofia Pro Bold", size: 20))
                                        .foregroundColor(Color.ui.pastel)
                                }
                            }.frame(height: 50)
                        }else{
                            Button {
                                withAnimation {
                                    viewModel.didAnswered = false
                                    viewModel.isFinished = true
                                    mode.wrappedValue.dismiss()
                                }
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20).fill(Color.ui.blue)
                                    Text("Zakończ")
                                        .font(Font.custom("Sofia Pro Bold", size: 20))
                                        .foregroundColor(Color.ui.pastel)
                                }
                            }.frame(height: 50)
                        }
                    }
                    
                }.padding(.vertical)
                    .padding(.bottom, 45)
                    .padding(.horizontal, 30)
                
            }
        }.edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

//struct LessonView_Previews: PreviewProvider {
//    static var previews: some View {
//        LessonView(lesson:
//            Lesson(title: "zmienne", image: "zmienne", topicsArray: [
//                TopicsArray(topics: [
//                    Topic(mainText: "Przykładem zmiennej typu int jest:", first: "50", second: "50,5", third: "pięć", correct: "50", taskType: .abc)
//                ], languageType: .cpp)
//            ]), topicsArray: [TopicsArray(topics: [
//                Topic(mainText: "Przykładem zmiennej typu int jest:", first: "50", second: "50,5", third: "pięć", correct: "50", taskType: .abc)
//            ], languageType: .cpp)]
//        )
//    }
//}
