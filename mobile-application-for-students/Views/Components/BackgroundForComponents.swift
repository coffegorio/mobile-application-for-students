//
//  BackgroundForComponents.swift
//  mobile-application-for-students
//
//  Created by Егорио on 18.12.2024.
//

import UIKit

class BackgroundForComponents: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = Styles.Colors.appBlackColor
        self.layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
