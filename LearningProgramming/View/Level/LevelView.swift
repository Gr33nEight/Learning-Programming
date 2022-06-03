//
//  LowLevelView.swift
//  LearningProgramming
//
//  Created by Natanael  on 19/11/2021.
//

import SwiftUI

struct LevelView: View {
    let lessons : [Lesson]
    @Environment(\.presentationMode) var mode
    var body: some View {
        NavigationView{
            ZStack{
                Color.ui.pastel.ignoresSafeArea()
                ScrollView{
                    VStack{
                        HStack{
                            VStack(alignment: .leading, spacing: 30){
                                Button {
                                    mode.wrappedValue.dismiss()
                                } label: {
                                    ZStack{
                                        BlurView(style: .extraLight)
                                            .clipShape(Circle())
                                            .frame(width: 50, height: 50)
                                        Image(systemName: "chevron.left")
                                            .foregroundColor(Color.ui.darkBlue)
                                            .font(Font.custom("Sofia Pro Bold", size: 20))
                                    }
                                }
                                Text("Lekcje")
                                    .font(Font.custom("Sofia Pro Bold", size: 40))
                                    .foregroundColor(Color.ui.darkBlue)
                            }.padding(.horizontal)
                            Spacer()
                        }.edgesIgnoringSafeArea(.top)
                        .padding()
                        ScrollView([.horizontal], showsIndicators: false){
                            HStack(alignment:.top, spacing: 40){
                                ForEach(lessons) { lesson in
                                    NavigationLink {
                                        LessonView(lesson: lesson, topicsArray: lesson.topicsArray)
                                    } label: {
                                        LessonCellView(lesson: lesson)
                                    }
                                }
                            }.padding(.trailing, 50)
                            .padding(50)
                        }
                        HStack{
                            VStack(alignment: .leading, spacing: 30){
                                Text("Testy")
                                    .font(Font.custom("Sofia Pro Bold", size: 40))
                                    .foregroundColor(Color.ui.darkBlue)
                            }.padding(.horizontal)
                            Spacer()
                        }.padding()
                        VStack(spacing: 20){
                            ForEach(lessons){ lesson in
                                NavigationLink {
                                    
                                } label: {
                                    ZStack{
                                        Color.white.cornerRadius(30)
                                        HStack{
                                            Text(lesson.title)
                                                .font(Font.custom("Sofia Pro Bold", size: 23))
                                                .foregroundColor(Color.ui.blue)
                                            Spacer()
                                            HStack{
                                                Text("Wynik:")
                                                    .font(Font.custom("Sofia Pro Bold", size: 20))
                                                    .foregroundColor(Color.ui.pastel)
                                                Text("68%")
                                                    .font(Font.custom("Sofia Pro Bold AZ", size: 20))
                                                    .foregroundColor(Color.ui.blue)
                                                
                                            }
                                        }.padding()
                                    }
                                }.frame(height: 80)
                                    .padding(.horizontal, 30)

                            }
                        }
                        Spacer()
                    }
                }
            }
            
            .hiddenNavigationBarStyle()
        }
        .hiddenNavigationBarStyle()
        .foregroundColor(Color.ui.darkBlue)
        .navigationBarBackButtonHidden(true)
            
    }
}


struct LessonCellView : View {
    @EnvironmentObject var viewModel: LevelViewModel
    let lesson: Lesson
    @State var passedTopics: Int = UserDefaults.standard.value(forKey: "passedTopics") as? Int ?? 0
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).minX
        
        let diff = abs(x - 45)
        if diff < 100 {
            scale = 1 + (110 - diff) / 500
        }
        return scale
    }
    private func showMore(proxy: GeometryProxy) -> Bool {
        var show: Bool = false
        
        let x = proxy.frame(in: .global).minX
        
        let diff = abs(x - 45)
        if diff < 100 {
            show.toggle()
        }
        return show
    }
    
    var body: some View{
        GeometryReader { proxy in
            let scale = getScale(proxy: proxy)
            let show = showMore(proxy: proxy)
            ZStack(alignment: .top){
                Color.white.cornerRadius(30)
                    .frame(height: show ? 350 : 250)
                
                VStack(alignment: .center, spacing: 15){
                    Text(lesson.title)
                        .padding(.top)
                        .padding()
                        .font(Font.custom("Sofia Pro Bold", size: 25))
                        .foregroundColor(Color.ui.darkestBlue)
                    Image(lesson.image)
                        .resizable()
                        .foregroundColor(Color.ui.blue)
                        .frame(width: 100, height: 100)
                    if show {
                        if !viewModel.isFinished{
                            VStack(alignment:.center){
                                ZStack(alignment: .leading){
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.ui.pastel)
                                        .frame(width: 180, height: 20)
                                        .padding()
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.ui.green)
                                        .frame(width: CGFloat(viewModel.passedTopics*180/lesson.topicsArray.first!.topics.count), height: 20)
                                }.frame(width: 180, height: 30)
                                    .padding(.vertical)
                                HStack(spacing: 5){
                                    Text("\(viewModel.passedTopics)")
                                        .font(Font.custom("Sofia Pro Bold", size: 17))
                                        .foregroundColor(Color.ui.blue)
                                    Text("/ \(lesson.topicsArray.first!.topics.count)")
                                        .font(Font.custom("Sofia Pro Thin", size: 17))
                                        .foregroundColor(Color.ui.pastel)
                                }
                            }
                        }else{
                            Image(systemName: "checkmark")
                                .font(.largeTitle)
                                .foregroundColor(Color.ui.green)
                                .padding(.top, 30)
                        }
                    }
                    
                    Spacer()
                }
            }
            .animation(.default)
            .scaleEffect(CGSize(width: scale, height: scale))
        }.frame(width: 250, height: 350)
            
    }
}


//struct LevelView_Previews: PreviewProvider {
//    static var previews: some View {
//        LevelView(lessons: [Lesson(title: "Zmienne", image: "zmienne", topicsArray: [TopicsArray(topics: [Topic(question: "", taskType: .writeAnswer)], languageType: .swift)])])
//    }
//}

