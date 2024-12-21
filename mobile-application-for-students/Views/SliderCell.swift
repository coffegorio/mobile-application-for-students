//
//  SliderCell.swift
//  mobile-application-for-students
//
//  Created by Егорио on 21.12.2024.
//

import UIKit
import SnapKit

class SliderCell: UICollectionViewCell {
    
    var titleLabel = AppLabel(text: "", textColor: Styles.Colors.appBlackColor, textAlignment: .left, fontSize: 24, fontWeight: .bold)
    var subtitleLabel = AppLabel(text: "", textColor: Styles.Colors.appBlackColor, textAlignment: .left, fontSize: 20, fontWeight: .regular)
    var backButton = AppButton(text: "Назад", fontSize: 20, fontWeight: .regular)
    
    var guitarVectorImage = AppImageView(imageName: "guitar")
    var drumsVectorImage = AppImageView(imageName: "drums")
    
    // Поле ввода номера телефона
    var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите номер телефона"
        textField.backgroundColor = Styles.Colors.appBlackColor
        textField.textColor = .white // Белый текст
        textField.layer.cornerRadius = 10
        textField.keyboardType = .phonePad
        textField.isHidden = true // Скрыто по умолчанию
        
        // Установка белого цвета для placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите номер телефона",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        // Создаем левую вью для отступа
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always // Отображаем всегда

        return textField
    }()

    
    // UISegmentedControl для выбора направления
    var directionSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Барабаны", "Гитара", "Вокал"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.isHidden = true // Скрыто по умолчанию
        segmentedControl.backgroundColor = Styles.Colors.appBlackColor
        
        // Настройка текста в сегментах
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white, // Белый текст
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black, // Черный текст для выделенного сегмента
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        return segmentedControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(phoneNumberTextField)
        contentView.addSubview(directionSegmentedControl)
        contentView.addSubview(backButton)
        contentView.addSubview(guitarVectorImage)
        contentView.addSubview(drumsVectorImage)
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
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(44)
        }
        
        directionSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        guitarVectorImage.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(60)
        }
        
        drumsVectorImage.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

