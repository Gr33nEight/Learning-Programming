//
//  LearningProgrammingApp.swift
//  LearningProgramming
//
//  Created by Natanael  on 19/11/2021.
//

import SwiftUI
import Firebase

@main
struct LearningProgrammingApp: App {
    
    init(){
        Firebase.FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
