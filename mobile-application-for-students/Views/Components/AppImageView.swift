//
//  LogoView.swift
//  mobile-application-for-students
//
//  Created by Егорио on 18.12.2024.
//

import UIKit

class AppImageView: UIImageView {

    init(imageName: String) {
        super.init(frame: .zero)
        
        self.image = UIImage(named: imageName)
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
