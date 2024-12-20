//
//  KeyboardDismissExt.swift
//  mobile-application-for-students
//
//  Created by Егорио on 19.12.2024.
//

import Foundation
import UIKit

// Расширение для UIViewController
extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
