//
//  TopicArray.swift
//  LearningProgramming
//
//  Created by Natanael  on 21/11/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct TopicsArray: Identifiable {
    @DocumentID var id : String?
    var topics: [Topic]
    var languageType: LanguageType
}
