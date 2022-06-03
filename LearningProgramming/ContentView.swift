//
//  ContentView.swift
//  LearningProgramming
//
//  Created by Natanael  on 19/11/2021.
//

import SwiftUI

struct ContentView: View {
    var levelViewModel = LevelViewModel()
    @EnvironmentObject var authViewModel : AuthViewModel
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
            }else{
                MainScreen().environmentObject(levelViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
