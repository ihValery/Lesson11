//
//  UserModel.swift
//  Lesson10PersonalityQuiz
//
//  Created by Валерий Игнатьев on 04.02.2021.
//

import Foundation

enum Gender: String, Codable {
    case man
    case woman
}

struct UserModel: Codable {
    var email : String?
    var pass  : String?
    var anketa: Anketa?
}

struct Anketa: Codable {
    var name         : String?
    var surName      : String?
    var dateOfBirth  : String?
    var gender       : Gender?
    var isSmoke      : Bool?
    var isVegaterian : Bool?
    var numOfChildren: Int?
    
    
}

