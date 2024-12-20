//
//  GreetingsScreenViewModel.swift
//  mobile-application-for-students
//
//  Created by Егорио on 20.12.2024.
//

import Foundation
import Combine

class GreetingsScreenViewModel {
    // Output: события для обработки на экране
    enum Output {
        case moveToAuthScreen
        case moveToNewStudentScreen
    }
    
    // Output событий
    let output = PassthroughSubject<Output, Never>()
    
    // Обработка нажатий кнопок
    func didTapLoginButton() {
        output.send(.moveToAuthScreen)
    }
    
    func didTapNewStudentButton() {
        output.send(.moveToNewStudentScreen)
    }
}
