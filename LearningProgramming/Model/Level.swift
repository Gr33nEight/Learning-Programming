//
//  Lesson.swift
//  LearningProgramming
//
//  Created by Natanael  on 19/11/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Level: Identifiable {
    var id = UUID()
    var lessons: [Lesson]
    var name: String
}
