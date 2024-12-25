//
//  NewsScreenVC.swift
//  mobile-application-for-students
//
//  Created by Егорио on 24.12.2024.
//

import UIKit
import SnapKit

class NewsScreenVC: UIViewController {
   
    private let logoImage = AppImageView(imageName: "logo")
    private let titleBackground = BackgroundForComponents()
    private let titleLabel = AppLabel(
        text: "Новости и события",
        textColor: Styles.Colors.appWhiteColor,
        textAlignment: .center,
        fontSize: 16,
        fontWeight: .bold
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor
        
        [
            logoImage,
            titleBackground,
            titleLabel
        ].forEach { view.addSubview($0) }
        
    }
    
    private func setupConstraints() {
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(40)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        titleBackground.snp.makeConstraints { make in
            make.leading.equalTo(logoImage.snp.trailing).offset(20) // Отступ от лого
            make.centerY.equalTo(logoImage) // Вертикальное центрирование с лого
            make.trailing.equalToSuperview().offset(-20) // Отступ от правого края супервью
            make.height.equalTo(50) // Высота фона
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleBackground) // Вертикальное центрирование с фоном
            make.centerX.equalTo(titleBackground)
        }
    }
}
