//
//  SliderCell.swift
//  mobile-application-for-students
//
//  Created by Егорио on 21.12.2024.
//

import UIKit
import SnapKit

class SliderCell: UICollectionViewCell {
    
    private var titleLabel = AppLabel(text: "", textColor: Styles.Colors.appBlackColor, textAlignment: .left, fontSize: 24, fontWeight: .bold)
    private var subtitleLabel = AppLabel(text: "", textColor: Styles.Colors.appBlackColor, textAlignment: .left, fontSize: 20, fontWeight: .regular)
    private let backButton = AppButton(text: "Назад", fontSize: 20, fontWeight: .regular)
    private let descriptionLabel = AppLabel(text: "Заполните небольшую форму! После заполнения мы обязательно свяжемся с вами и поберем время Вашего первого урока специально для Вас!", textColor: Styles.Colors.appBlackColor, textAlignment: .left, fontSize: 20, fontWeight: .regular)
    private let sentInfoButton = AppButton(text: "Заполнить", fontSize: 20, fontWeight: .regular)
    
    var guitarVectorImage = AppImageView(imageName: "guitar")
    var drumsVectorImage = AppImageView(imageName: "drums")
    
//    var phoneNumberTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Введите номер телефона"
//        textField.backgroundColor = Styles.Colors.appBlackColor
//        textField.textColor = .white
//        textField.layer.cornerRadius = 10
//        textField.keyboardType = .phonePad
//        textField.isHidden = true
//        textField.attributedPlaceholder = NSAttributedString(
//            string: "Введите номер телефона",
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
//        )
//        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
//        textField.leftView = leftPaddingView
//        textField.leftViewMode = .always
//        return textField
//    }()
//    
//    var nameTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Как Вас зовут?"
//        textField.backgroundColor = Styles.Colors.appBlackColor
//        textField.textColor = .white
//        textField.layer.cornerRadius = 10
//        textField.isHidden = true
//        textField.attributedPlaceholder = NSAttributedString(
//            string: "Ваше имя",
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
//        )
//        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
//        textField.leftView = leftPaddingView
//        textField.leftViewMode = .always
//        return textField
//    }()
//    
//    var directionSegmentedControl: UISegmentedControl = {
//        let segmentedControl = UISegmentedControl(items: ["Барабаны", "Гитара", "Вокал"])
//        segmentedControl.selectedSegmentIndex = 0
//        segmentedControl.isHidden = true
//        segmentedControl.backgroundColor = Styles.Colors.appBlackColor
//        let normalTextAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.white,
//            .font: UIFont.systemFont(ofSize: 14)
//        ]
//        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.black,
//            .font: UIFont.boldSystemFont(ofSize: 14)
//        ]
//        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
//        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
//        return segmentedControl
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(backButton)
        contentView.addSubview(sentInfoButton)
        contentView.addSubview(guitarVectorImage)
        contentView.addSubview(drumsVectorImage)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(60)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.leading.equalTo(subtitleLabel)
            make.trailing.equalTo(subtitleLabel)
        }
        
//        phoneNumberTextField.snp.makeConstraints { make in
//            make.top.equalTo(subtitleLabel.snp.bottom).offset(40)
//            make.leading.trailing.equalToSuperview().inset(40)
//            make.height.equalTo(44)
//        }
//        
//        nameTextField.snp.makeConstraints { make in
//            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
//            make.leading.trailing.equalToSuperview().inset(40)
//            make.height.equalTo(44)
//        }
//        
//        directionSegmentedControl.snp.makeConstraints { make in
//            make.top.equalTo(nameTextField.snp.bottom).offset(20)
//            make.leading.trailing.equalToSuperview().inset(40)
//        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        sentInfoButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(50)
        }
        
        guitarVectorImage.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(80)
        }
        
        drumsVectorImage.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: ItemSlider, isLastSlide: Bool, isFirstSlide: Bool, isSecondSlide: Bool) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        
//        phoneNumberTextField.isHidden = !isLastSlide
//        nameTextField.isHidden = !isLastSlide
//        directionSegmentedControl.isHidden = !isLastSlide
        
        descriptionLabel.isHidden = !isLastSlide
        sentInfoButton.isHidden = !isLastSlide
        backButton.isHidden = !isFirstSlide
        guitarVectorImage.isHidden = !isSecondSlide
        drumsVectorImage.isHidden = !isFirstSlide
        
        backButton.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        sentInfoButton.addTarget(self, action: #selector(handleMoveToSentInfoScreenTapped), for: .touchUpInside)
        
        contentView.backgroundColor = item.color
    }
    
    @objc private func handleBackButtonTapped() {
        NotificationCenter.default.post(name: .backButtonTapped, object: nil)
    }
    
    @objc private func handleMoveToSentInfoScreenTapped() {
        NotificationCenter.default.post(name: .moveToSentInfoScreenTapped, object: nil)
    }
}
