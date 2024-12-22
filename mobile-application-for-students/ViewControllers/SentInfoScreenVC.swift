//
//  SentInfoScreenVC.swift
//  mobile-application-for-students
//
//  Created by Егорио on 22.12.2024.
//

import UIKit
import SnapKit

class SentInfoScreenVC: UIViewController {

    private let logoImage = AppImageView(imageName: "logo")
    private let titleBackground = BackgroundForComponents()
    private let titleLabel = AppLabel(
        text: "Заполните информацию",
        textColor: Styles.Colors.appWhiteColor,
        textAlignment: .center,
        fontSize: 16,
        fontWeight: .bold
    )
    
    private let sentButton = AppButton(text: "Отправить!", fontSize: 18, fontWeight: .regular)
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите номер телефона"
        textField.backgroundColor = Styles.Colors.appBlackColor
        textField.textColor = .white
        textField.layer.cornerRadius = 10
        textField.keyboardType = .phonePad
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите номер телефона",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Как Вас зовут?"
        textField.backgroundColor = Styles.Colors.appBlackColor
        textField.textColor = .white
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(
            string: "Ваше имя",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private let directionSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Барабаны", "Гитара", "Вокал"])
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
    
    private let directionSegmentedControlAge: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Для ребенка", "Для себя"])
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
    
    private let vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    private var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupActions()
        hideKeyboardWhenTappedAround()
        
        overrideUserInterfaceStyle = .light
        
        // Добавление наблюдателей для клавиатуры
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupStackView() {
        vStack.addArrangedSubview(nameTextField)
        vStack.addArrangedSubview(phoneNumberTextField)
        vStack.addArrangedSubview(directionSegmentedControl)
        vStack.addArrangedSubview(directionSegmentedControlAge)
    }
    
    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor
        
        scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        scrollView.delaysContentTouches = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(vStack)
        scrollView.addSubview(logoImage)
        scrollView.addSubview(titleBackground)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(sentButton)
        
        setupStackView()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(40)
            make.height.equalTo(50)
            make.width.equalTo(50)
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
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        vStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(sentButton.snp.top).offset(-20) // добавляем отступ снизу
        }
        
        sentButton.snp.makeConstraints { make in
            make.top.equalTo(vStack.snp.bottom).offset(20)
            make.leading.equalTo(vStack)
            make.trailing.equalTo(vStack)
            make.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        sentButton.addTarget(self, action: #selector(sentButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Keyboard Handling
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)

        // Обновляем отступы для ScrollView
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
        
        // Прокручиваем ScrollView, чтобы текущий активный элемент был виден
        if let firstResponder = view.findFirstResponder() {
            var visibleRect = self.view.frame
            visibleRect.size.height -= keyboardHeight
            if !visibleRect.contains(firstResponder.frame.origin) {
                scrollView.scrollRectToVisible(firstResponder.frame, animated: true)
            }
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        // Сбрасываем отступы при скрытии клавиатуры
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Устанавливаем contentSize для ScrollView
        scrollView.contentSize = CGSize(width: view.frame.width, height: vStack.frame.maxY + sentButton.frame.height + 40)
    }
    
    // MARK: - Show Alert
    
    @objc func sentButtonTapped() {
        let alertController = UIAlertController(
            title: "Спасибо!",
            message: "Спасибо за предоставленную информацию. Мы скоро с вами свяжемся.",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

private extension UIView {
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder {
            return self as? UIView
        }
        for subview in subviews {
            if let responder = subview.findFirstResponder() {
                return responder
            }
        }
        return nil
    }
}
