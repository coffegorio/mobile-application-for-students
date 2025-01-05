//
//  RegisterUserRequest.swift
//  mobile-application-for-students
//
//  Created by Егорио on 03.01.2025.
//

import Foundation

struct RegisterUserRequest {
    
    let name: String
    let surname: String
    let email: String
    let password: String
    let role: String
    let instrument: String
    let secondInstrument: String?
    let currentStage: Int?
    let currentLesson: Int?
    
}
