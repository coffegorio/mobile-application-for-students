//
//  RegisterStudentVC.swift
//  mobile-application-for-students
//
//  Created by Егорио on 04.01.2025.
//

import UIKit
import SnapKit

class RegisterStudentVC: UIViewController {
    
    private let scrollView = UIScrollView()
    private let content = UIView()

    private let logoImage = AppImageView(imageName: "logo")
    private let titleBackground = BackgroundForComponents()
    private let titleLabel = AppLabel(
        text: "Создать нового пользователя",
        textColor: Styles.Colors.appWhiteColor,
        textAlignment: .center,
        fontSize: 14,
        fontWeight: .bold
    )
    
    private let nameTextField = AppTextField(placeholder: "Введите имя", backgroundColor: Styles.Colors.appBlackColor)
    private let surnameTextField = AppTextField(placeholder: "Введите фамилию", backgroundColor: Styles.Colors.appBlackColor)
    private let emailTextField = AppTextField(placeholder: "Введите электронную почту", backgroundColor: Styles.Colors.appBlackColor)
    private let passwordTextField = AppTextField(placeholder: "Введите пароль", backgroundColor: Styles.Colors.appBlackColor)
    private let roleTextField = AppTextField(placeholder: "Введите роль пользователя", backgroundColor: Styles.Colors.appBlackColor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor
        navigationController?.isNavigationBarHidden = true
        
        [
            logoImage,
            titleBackground,
            titleLabel,
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
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
