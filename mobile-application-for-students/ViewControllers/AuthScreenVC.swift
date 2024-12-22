//
//  AuthScreen.swift
//  mobile-application-for-students
//
//  Created by Егорио on 20.12.2024.
//

import UIKit
import SnapKit

class AuthScreenVC: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let backButton = AppButton(text: "Назад", fontSize: 18, fontWeight: .regular)
    private let logoImage = AppImageView(imageName: "logo")
    private let titleBackground = BackgroundForComponents()
    private let titleLabel = AppLabel(
        text: "Авторизация",
        textColor: Styles.Colors.appWhiteColor,
        textAlignment: .center,
        fontSize: 20,
        fontWeight: .bold
    )
    private let subtitleLabel = AppLabel(
        text: "Войдите в свой профиль ученика. Если Вы являетесь нашим учеником, но у Вас нет своего профиля, Вы можете обратиться к администраторам с помощью любого удобного для Вас мессенджера, или напрямую в школе.",
        textColor: Styles.Colors.appBlackColor,
        textAlignment: .left,
        fontSize: 20,
        fontWeight: .regular
    )
    private let loginTextField = AppTextField(placeholder: "Логин", backgroundColor: Styles.Colors.appBlackColor)
    private let passwordTextField = AppTextField(placeholder: "Пароль", backgroundColor: Styles.Colors.appBlackColor)
    private let moveToAuthScreenButton = AppButton(text: "Войти", fontSize: 18, fontWeight: .regular)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupActions()
        setupKeyboardObservers()
        hideKeyboardWhenTappedAround()
    }

    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor
        navigationController?.setNavigationBarHidden(true, animated: false)

        scrollView.isScrollEnabled = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [
            backButton,
            logoImage,
            titleBackground,
            titleLabel,
            subtitleLabel,
            loginTextField,
            passwordTextField,
            moveToAuthScreenButton
        ].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.leading.equalToSuperview().offset(40)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.5)
        }

        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(40)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }

        titleBackground.snp.makeConstraints { make in
            make.centerX.equalTo(titleLabel)
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(titleLabel).offset(30)
            make.width.equalTo(titleLabel).offset(30)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImage)
            make.leading.equalTo(logoImage.snp.trailing).offset(40)
            make.trailing.equalToSuperview().inset(40)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleBackground.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }

        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }

        moveToAuthScreenButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
            make.bottom.equalTo(backButton.snp.top).offset(-30)
        }
    }

    private func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        scrollView.isScrollEnabled = true
        scrollView.contentInset.bottom = keyboardHeight
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.isScrollEnabled = false
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
