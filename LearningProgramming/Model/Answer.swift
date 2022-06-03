//
//  Answere.swift
//  LearningProgramming
//
//  Created by Natanael  on 22/11/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Answer: Identifiable, Decodable {
    @DocumentID var id: String?
    var text : String
}

