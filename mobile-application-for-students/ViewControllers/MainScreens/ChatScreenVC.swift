//
//  ChatScreenVC.swift
//  mobile-application-for-students
//
//  Created by Егорио on 24.12.2024.
//

import UIKit
import SnapKit

class ChatScreenVC: UIViewController {
    
    private let logoImage = AppImageView(imageName: "logo")
    private let titleBackground = BackgroundForComponents()
    private let titleLabel = AppLabel(
        text: "Сообщения",
        textColor: Styles.Colors.appWhiteColor,
        textAlignment: .center,
        fontSize: 16,
        fontWeight: .bold
    )
    
    private var adminChatLabel: UILabel = {
        let label = AppLabel(text: "Админам не обязательно читать чаты учеников с преподавателями, это личное :))", textColor: Styles.Colors.appBlackColor, textAlignment: .left, fontSize: 18, fontWeight: .regular)
        label.isHidden = true
        return label
    }()
    
    private var studentsChatLabel: UILabel = {
        let label = AppLabel(text: "В разработке...", textColor: Styles.Colors.appBlackColor, textAlignment: .left, fontSize: 18, fontWeight: .regular)
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        checkRoleAndShowLabel()
    }
    
    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor
        overrideUserInterfaceStyle = .light
        
        [
            logoImage,
            titleBackground,
            titleLabel,
            adminChatLabel,
            studentsChatLabel
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
        
        adminChatLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.centerY.equalToSuperview()
        }
        
        studentsChatLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func checkRoleAndShowLabel() {
        AuthService.shared.fetchUserRole { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let role):
                    
                    self?.adminChatLabel.isHidden = role != "admin"
                    
                    self?.studentsChatLabel.isHidden = role != "student"
                    
                case .failure(let error):
                    print("Failed to fetch user role: \(error.localizedDescription)")
                }
            }
        }
    }
}
