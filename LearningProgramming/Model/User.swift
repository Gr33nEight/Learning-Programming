//
//  User.swift
//  LearningProgramming
//
//  Created by Natanael  on 01/12/2021.
//

import FirebaseFirestoreSwift

struct User : Identifiable, Decodable {
    let username: String
    let email: String
    let fullname: String
    var isAdmin: Bool = false
    @DocumentID var id: String?
}
