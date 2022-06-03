//
//  Topic.swift
//  LearningProgramming
//
//  Created by Natanael  on 21/11/2021.
//

import Firebase
import FirebaseFirestoreSwift

struct Topic: Identifiable {
    @DocumentID var id : String?
    var question : String
    var code : String
    var answers : [Answer]
    var correctAnswer: String
    var numberOfLines: Int
    var taskType: TaskType
    
}
