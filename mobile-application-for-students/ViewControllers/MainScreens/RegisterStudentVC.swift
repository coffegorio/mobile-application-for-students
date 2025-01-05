//
//  RegisterStudentVC.swift
//  mobile-application-for-students
//
//  Created by Егорио on 04.01.2025.
//

import UIKit
import SnapKit

class RegisterStudentVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    private let firstDirectionLabel = AppLabel(text: "Первое направление", textColor: Styles.Colors.appBlackColor, textAlignment: .left, fontSize: 18, fontWeight: .regular)
    
    private let directionSegmentedControlFirstInstrument: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Барабаны", "Гитара", "Вокал", "Нет"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = Styles.Colors.appBlackColor
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        return segmentedControl
    }()
    
    private let secondDirectionLabel = AppLabel(text: "Второе направление", textColor: Styles.Colors.appBlackColor, textAlignment: .left, fontSize: 18, fontWeight: .regular)
    
    private let directionSegmentedControlSecondInstrument: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Барабаны", "Гитара", "Вокал", "Нет"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = Styles.Colors.appBlackColor
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        return segmentedControl
    }()
    
    private let directionSegmentedControlUserRole: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Преподаватель", "Админ", "Ученик"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = Styles.Colors.appBlackColor
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        return segmentedControl
    }()
    
    private let currentStage = AppTextField(placeholder: "Текущий ступень", backgroundColor: Styles.Colors.appBlackColor)
    private let stages = [1, 2, 3, 4]
    private let currentStagePicker = UIPickerView()
    
    private let currentLesson = AppTextField(placeholder: "Текущий урок", backgroundColor: Styles.Colors.appBlackColor)
    private let lessons = Array(1...24)
    private let currentLessonPicker = UIPickerView()
    
    private let registerButton = AppButton(text: "Зарегистрировать", fontSize: 18, fontWeight: .regular)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupPickers()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor
        overrideUserInterfaceStyle = .light
        
        view.addSubview(scrollView)
        scrollView.addSubview(content)
        scrollView.delaysContentTouches = false
        
        [
            logoImage,
            titleBackground,
            titleLabel,
            nameTextField,
            surnameTextField,
            emailTextField,
            passwordTextField,
            directionSegmentedControlUserRole,
            firstDirectionLabel,
            directionSegmentedControlFirstInstrument,
            secondDirectionLabel,
            directionSegmentedControlSecondInstrument,
            currentStage,
            currentLesson,
            registerButton
        ].forEach { content.addSubview($0) }
        
        // Скрываем элементы по умолчанию
        firstDirectionLabel.isHidden = true
        directionSegmentedControlFirstInstrument.isHidden = true
        secondDirectionLabel.isHidden = true
        directionSegmentedControlSecondInstrument.isHidden = true
        currentStage.isHidden = true
        currentLesson.isHidden = true
        
        // Добавляем обработчик для сегмент-контрола роли
        directionSegmentedControlUserRole.addTarget(self, action: #selector(roleChanged), for: .valueChanged)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        content.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview() // Обязательно для корректной прокрутки
        }
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(50)
        }
        
        titleBackground.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(titleBackground)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleBackground.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        directionSegmentedControlUserRole.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        registerButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-100) // Указание нижнего края контента
        }
        
        updateConstraintsForRole() // Обновление видимости
    }
    
    private func updateConstraintsForRole() {
        let isStudent = directionSegmentedControlUserRole.selectedSegmentIndex == 2 // Индекс "Ученик"
        
        if isStudent {
            firstDirectionLabel.snp.remakeConstraints { make in
                make.top.equalTo(directionSegmentedControlUserRole.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(20)
            }
            
            directionSegmentedControlFirstInstrument.snp.remakeConstraints { make in
                make.top.equalTo(firstDirectionLabel.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(44)
            }
            
            secondDirectionLabel.snp.remakeConstraints { make in
                make.top.equalTo(directionSegmentedControlFirstInstrument.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(20)
            }
            
            directionSegmentedControlSecondInstrument.snp.remakeConstraints { make in
                make.top.equalTo(secondDirectionLabel.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(44)
            }
            
            currentStage.snp.remakeConstraints { make in
                make.top.equalTo(directionSegmentedControlSecondInstrument.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(44)
            }
            
            currentLesson.snp.remakeConstraints { make in
                make.top.equalTo(currentStage.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(44)
            }
            
            registerButton.snp.remakeConstraints { make in
                make.top.equalTo(currentLesson.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(50)
                make.bottom.equalToSuperview().offset(-100)
            }
        } else {
            registerButton.snp.remakeConstraints { make in
                make.top.equalTo(directionSegmentedControlUserRole.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(50)
                make.bottom.equalToSuperview().offset(-100)
            }
        }
    }
    
    
    private func setupPickers() {
        // Настройка UIPickerView для currentStage
        currentStagePicker.delegate = self
        currentStagePicker.dataSource = self
        currentStage.inputView = currentStagePicker
        
        // Настройка UIPickerView для currentLesson
        currentLessonPicker.delegate = self
        currentLessonPicker.dataSource = self
        currentLesson.inputView = currentLessonPicker
    }
    
    @objc private func roleChanged() {
        let isStudent = directionSegmentedControlUserRole.selectedSegmentIndex == 2 // Индекс "Ученик"
        
        // Показываем или скрываем элементы
        firstDirectionLabel.isHidden = !isStudent
        directionSegmentedControlFirstInstrument.isHidden = !isStudent
        secondDirectionLabel.isHidden = !isStudent
        directionSegmentedControlSecondInstrument.isHidden = !isStudent
        currentStage.isHidden = !isStudent
        currentLesson.isHidden = !isStudent
        
        // Обновляем констрейнты
        updateConstraintsForRole()
        
        if directionSegmentedControlUserRole.selectedSegmentIndex == 2 {
            firstDirectionLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            firstDirectionLabel.alpha = 0
            
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: []) {
                self.firstDirectionLabel.transform = .identity
                self.firstDirectionLabel.alpha = 1
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.firstDirectionLabel.alpha = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == currentStagePicker {
            return stages.count
        } else if pickerView == currentLessonPicker {
            return lessons.count
        }
        return 0
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == currentStagePicker {
            return "Ступень \(stages[row])"
        } else if pickerView == currentLessonPicker {
            return "Урок \(lessons[row])"
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == currentStagePicker {
            currentStage.text = "Стадия \(stages[row])"
        } else if pickerView == currentLessonPicker {
            currentLesson.text = "Урок \(lessons[row])"
        }
    }
}

