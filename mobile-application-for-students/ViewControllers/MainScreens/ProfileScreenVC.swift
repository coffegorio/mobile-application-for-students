//
//  ProfileScreenVC.swift
//  mobile-application-for-students
//
//  Created by Егорио on 24.12.2024.
//

import UIKit
import SnapKit
import FirebaseFirestore

class ProfileScreenVC: UIViewController {
    
    private let greetingsLabel = AppLabel(
        text: "",
        textColor: Styles.Colors.appBlackColor,
        textAlignment: .left,
        fontSize: 24,
        fontWeight: .regular
    )
    
    private let username = AppLabel(
        text: "",
        textColor: Styles.Colors.appBlackColor,
        textAlignment: .left,
        fontSize: 24,
        fontWeight: .bold
    )
    
    private let moveToRegisterStudentVCButton: AppButton = {
        let button = AppButton(text: "Зарегистрировать пользователя", fontSize: 18, fontWeight: .regular)
        button.isHidden = true // Кнопка скрыта по умолчанию
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        updateGreeting()
        loadUserNameAndUpdateUI()
        checkUserRoleAndUpdateUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor
        
        // Добавляем элементы в иерархию
        [
            greetingsLabel,
            username,
            moveToRegisterStudentVCButton
        ].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        
        greetingsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }
        
        username.snp.makeConstraints { make in
            make.top.equalTo(greetingsLabel.snp.bottom).offset(10)
            make.leading.equalTo(greetingsLabel)
            make.trailing.equalToSuperview().inset(40)
        }
        
        moveToRegisterStudentVCButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(120)
            make.height.equalTo(50)
        }
    }
    
    private func updateGreeting() {
        greetingsLabel.text = GreetingModel.getGreeting()
    }
    
    private func loadUserNameAndUpdateUI() {
        AuthService.shared.fetchAndUpdateUserNameIfNeeded { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let name):
                    self?.username.text = name
                case .failure(let error):
                    self?.username.text = "Error"
                    print("Failed to fetch user name: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func checkUserRoleAndUpdateUI() {
        AuthService.shared.fetchUserRole { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let role):
                    if role == "admin" {
                        self?.moveToRegisterStudentVCButton.isHidden = false
                        self?.setupActions()
                    } else {
                        self?.moveToRegisterStudentVCButton.isHidden = true
                    }
                case .failure(let error):
                    print("Failed to fetch user role: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func setupActions() {
        moveToRegisterStudentVCButton.addTarget(self, action: #selector(moveToRegisterStudentVC), for: .touchUpInside)
    }
    
    @objc private func moveToRegisterStudentVC() {
        let registerStudentVC = RegisterStudentVC()
        modalPresentationStyle = .fullScreen
        present(registerStudentVC, animated: true, completion: nil)
    }
}


