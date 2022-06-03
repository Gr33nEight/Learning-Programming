//
//  Enums.swift
//  LearningProgramming
//
//  Created by Natanael  on 21/11/2021.
//

import Foundation

enum LanguageType : String, CaseIterable {
    case cpp = ".cpp"
    case swift = ".swift"
    case python = ".python"
    
    var name : String {
        switch self{
        case .cpp: return "C++"
        case .swift: return "Swift"
        case .python: return "Python"
        }
    }
}

enum TaskType : String, CaseIterable {
    case explanation = ".explanation"
    case abc = ".abc"
    case writeAnswer = ".writeAnswer"
    case writeCode = ".writeCode"
    
    var name : String {
        switch self {
        case .explanation: return "Definicja"
        case .abc: return "Test abc"
        case .writeAnswer: return "Napisz odpowiedź"
        case .writeCode: return "Napisz kod"
        }
    }
}
