//
//  AppTextField.swift
//  mobile-application-for-students
//
//  Created by Егорио on 18.12.2024.
//

import UIKit

class AppTextField: UITextField {

    private let padding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    
    init(placeholder: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: Styles.Colors.appSecondaryColor,
            ]
        )
        
        self.textColor = Styles.Colors.appWhiteColor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10
        self.autocorrectionType = .no
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
