//
//  Styles.swift
//  mobile-application-for-students
//
//  Created by Егорио on 18.12.2024.
//

import UIKit

struct Styles {
    
    struct LabelSettings {
        static func configureDefaultLabel(_ label: UILabel) {
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
        }
    }
    
    struct Colors {
        static let appWhiteColor = UIColor.white
        static let appBlackColor = UIColor.black
        static let appSecondaryColor = UIColor.gray
        static let newsBackgroundColor = UIColor(hex: "EEE5E5")
    }
}
