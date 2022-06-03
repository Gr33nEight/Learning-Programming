//
//  Lesson.swift
//  LearningProgramming
//
//  Created by Natanael  on 21/11/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Lesson: Identifiable {
    @DocumentID var id : String?
    var title: String
    var image: String
    var topicsArray: [TopicsArray]
    
}
