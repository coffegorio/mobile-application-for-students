//
//  AuthScreenVC.swift
//  mobile-application-for-students
//
//  Created by Егорио on 19.12.2024.
//

import UIKit
import SnapKit
import Lottie
import Combine

class GreetingsScreenVC: UIViewController {

    private var animatedLogo: LottieAnimationView?
    private let viewModel = GreetingsScreenViewModel()
    private var cancellables = Set<AnyCancellable>()

    private let titleBackground = BackgroundForComponents()
    private let titleLabel = AppLabel(
        text: "НЕ ШКОЛА ГИТАРЫ",
        textColor: Styles.Colors.appWhiteColor,
        textAlignment: .center,
        fontSize: 20,
        fontWeight: .bold
    )
    private let subtitleLabel = AppLabel(
        text: "Войдите в свой профиль, что бы мы понимали, что Вы - наш ученик! Если Вы уже являетесь нашим учеником на одном из направлений, обратитесь к администраторам для создания профиля",
        textColor: Styles.Colors.appBlackColor,
        textAlignment: .left,
        fontSize: 20,
        fontWeight: .regular
    )
    private let moveToLoginButton = AppButton(text: "Я уже ученик!", fontSize: 18, fontWeight: .regular)
    private let moveToNewStudentButton = AppButton(text: "Я пока что не ученик!", fontSize: 18, fontWeight: .regular)

    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupAnimatedLogo()
        setupConstraints()
        bindViewModel()
    }

    private func setupAnimatedLogo() {
        animatedLogo = .init(name: "animatedLogo")
        animatedLogo!.contentMode = .scaleAspectFit
        animatedLogo!.loopMode = .loop
        animatedLogo!.animationSpeed = 1
        view.addSubview(animatedLogo!)
        animatedLogo!.play()

        animatedLogo!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
    }

    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor

        [moveToLoginButton, moveToNewStudentButton].forEach {
            buttonsStackView.addArrangedSubview($0)
        }

        [
            titleBackground,
            titleLabel,
            subtitleLabel,
            buttonsStackView
        ].forEach { view.addSubview($0) }

        moveToLoginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        moveToNewStudentButton.addTarget(self, action: #selector(didTapNewStudentButton), for: .touchUpInside)
    }

    private func setupConstraints() {
        titleBackground.snp.makeConstraints { make in
            make.centerX.equalTo(titleLabel)
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(titleLabel).offset(30)
            make.width.equalTo(titleLabel).offset(30)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(animatedLogo!.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleBackground.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }

        buttonsStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }

        moveToLoginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        moveToNewStudentButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }

    private func bindViewModel() {
        viewModel.output
            .sink { [weak self] output in
                switch output {
                case .moveToAuthScreen:
                    let authScreenVC = AuthScreenVC()
                    self?.navigationController?.pushViewController(authScreenVC, animated: true)
                case .moveToNewStudentScreen:
                    let newStudentScreenVC = NewStudentScreenVC()
                    self?.navigationController?.pushViewController(newStudentScreenVC, animated: true)
                }
            }
            .store(in: &cancellables)
    }




    @objc private func didTapLoginButton() {
        viewModel.didTapLoginButton()
    }

    @objc private func didTapNewStudentButton() {
        viewModel.didTapNewStudentButton()
    }
}
