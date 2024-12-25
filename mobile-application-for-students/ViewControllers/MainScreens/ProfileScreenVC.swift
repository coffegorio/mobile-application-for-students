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
    
    private let greetingsLabel = AppLabel(text: "", textColor: Styles.Colors.appBlackColor, textAlignment: .left, fontSize: 24, fontWeight: .regular)
    private let username = AppLabel(text: "", textColor: Styles.Colors.appBlackColor, textAlignment: .left, fontSize: 24, fontWeight: .bold)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        updateGreeting()
        fetchUserNameAndUpdateUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor
        
        [
            greetingsLabel,
            username
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
    }
    
    private func updateGreeting() {
            greetingsLabel.text = GreetingModel.getGreeting()
        }
    
    private func fetchUserNameAndUpdateUI() {
        AuthService.shared.fetchUserName { [weak self] result in
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
}
