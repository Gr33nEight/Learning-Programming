//
//  MainScreenUI.swift
//  LearningProgramming
//
//  Created by Natanael  on 21/11/2021.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var viewModel : LevelViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
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
    
    @State var isShown = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .top){
                Color.ui.pastel.ignoresSafeArea()
                HStack{
                    Button(action: {
                        authViewModel.signout()
                    }, label: {
                        Image(systemName: "person")
                            .padding()
                    })
                    Spacer()
                    if (authViewModel.currentUser?.isAdmin != nil) {
                        if (authViewModel.currentUser!.isAdmin){
                            Button(action: {
                                withAnimation {
                                    isShown = true
                                }
                            }, label: {
                                Image(systemName: "plus")
                                    .padding()
                            })
                        }
                    }
                }
                VStack{
                    VStack(alignment: .leading, spacing: 30){
                        Text("Naucz się \nProgramowania \nNa własnym\nTelefonie")
                            .font(Font.custom("Sofia Pro Bold", size: 40))
                            .foregroundColor(Color.ui.darkBlue)
                        Text("Wybierz jeden z poniższych poziomów zaawansowania")
                            .font(Font.custom("Sofia Pro ExtraLight", size: 25))
                            .foregroundColor(Color.ui.blue)
                    }.padding(30)
                    ScrollView([.horizontal], showsIndicators: false){
                        HStack(spacing: 40){
                            ForEach(viewModel.levels) { level in
                                NavigationLink {
                                    LevelView(lessons: level.lessons)
                                } label: {
                                    GeometryReader { proxy in
                                        let show = showMore(proxy: proxy)
                                        let scale = getScale(proxy: proxy)
                                        ZStack{
                                            if show {
                                                Color.ui.darkBlue.cornerRadius(30)
                                            }
                                            Color.white.cornerRadius(30)
                                                .frame(width: 193, height: 243)
                                            
                                            VStack(alignment: .leading, spacing: 15){
                                                Text(level.name)
                                                    .padding()
                                                    .font(Font.custom("Sofia Pro Bold", size: 30))
                                                    .foregroundColor(Color.ui.darkestBlue)
                                            }
                                        }.animation(.default)
                                        .scaleEffect(CGSize(width: scale, height: scale))
                                    }.frame(width: 200, height: 250)
                                }
                            }
                        }.padding(.trailing, 50)
                        .padding(50)
                    }
                }.padding(.top, 30)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.fullScreenCover(isPresented: $isShown) {} content: {
                AddDataView(isShown: $isShown)
            }

    }
}



struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
