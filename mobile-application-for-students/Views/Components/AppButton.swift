//
//  AppButton.swift
//  mobile-application-for-students
//
//  Created by Егорио on 18.12.2024.
//

import UIKit

class AppButton: UIButton {

    init(text: String, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        super.init(frame: .zero)
        
        // Настройка текста и шрифта
        self.setTitle(text, for: .normal)
        self.setTitleColor(Styles.Colors.appWhiteColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        
        // Настройка кнопки
        self.backgroundColor = Styles.Colors.appBlackColor
        self.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.layer.cornerRadius = 16

        // Добавляем анимации нажатия
        self.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        self.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed() {
        UIView.animate(withDuration: 0.05) {
            self.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }
    }
    
    @objc private func buttonReleased() {
        UIView.animate(withDuration: 0.05) {
            self.transform = CGAffineTransform.identity
        }
    }
}
