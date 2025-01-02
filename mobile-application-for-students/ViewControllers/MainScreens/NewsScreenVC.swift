//
//  NewsScreenVC.swift
//  mobile-application-for-students
//
//  Created by Егорио on 24.12.2024.
//

import UIKit
import SnapKit
import FirebaseFirestore

class NewsScreenVC: UIViewController {
    // Логотип и заголовок
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
    
    // Настройка UI
    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor
        //        navigationController?.navigationBar.isTranslucent = false
        overrideUserInterfaceStyle = .light
        
        [
            logoImage,
            titleBackground,
            titleLabel
        ].forEach { view.addSubview($0) }
    }
    
    // Настройка констрейнтов
    private func setupConstraints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(40)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        titleBackground.snp.makeConstraints { make in
            make.leading.equalTo(logoImage.snp.trailing).offset(20)
            make.centerY.equalTo(logoImage)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleBackground)
            make.centerX.equalTo(titleBackground)
        }
    }
}
