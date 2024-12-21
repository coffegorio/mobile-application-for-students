//
//  NewStudentScreen.swift
//  mobile-application-for-students
//
//  Created by Егорио on 20.12.2024.
//

import UIKit
import SnapKit

class NewStudentScreenVC: UIViewController {

    // MARK: - Properties

    private let sliderData: [ItemSlider] = [
        ItemSlider(color: Styles.Colors.appWhiteColor, title: "Мы одна большая музыкальная семья", subtitle: "Вместе мы создаём гармонию, поддерживаем друг друга и вдохновляем на новые свершения. Здесь каждый найдёт своё место.", imageName: ""),
        ItemSlider(color: Styles.Colors.appWhiteColor, title: "Твоя мечта, наша поддержка", subtitle: "Как в настоящей семье, мы всегда рядом: помогаем, учим и радуемся твоим успехам. Каждый аккорд — шаг к твоему будущему.", imageName: ""),
        ItemSlider(color: Styles.Colors.appWhiteColor, title: "Запишись на бесплатный первый урок!", subtitle: "Начать - лучший способ начать что - либо! Оставьте свой номер телефона и мы обязательно свяжемся с вами в ближайшее время и подберем время для Вашего первого урока!", imageName: "")
    ]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(SliderCell.self, forCellWithReuseIdentifier: "cell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.contentInsetAdjustmentBehavior = .never

        return collection
    }()

    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 0
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.keyboardDismissMode = .interactive
        return scroll
    }()

    private lazy var nextPageButton: UIView = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextSlide))

        let nextImg = UIImageView()
        nextImg.image = UIImage(systemName: "chevron.right.circle.fill")
        nextImg.contentMode = .scaleAspectFit
        nextImg.tintColor = Styles.Colors.appBlackColor
        nextImg.translatesAutoresizingMaskIntoConstraints = false

        let button = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tapGesture)
        button.addSubview(nextImg)

        nextImg.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(45)
        }

        button.snp.makeConstraints { make in
            make.size.equalTo(50)
        }

        return button
    }()

    private var pagers: [UIView] = []
    private var currentSlide = 0
    private let shape = CAShapeLayer()
    private var currentPageIndex: CGFloat = 0
    private var fromValue: CGFloat = 0

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollection()
        setupConstraints()
        setupControl()
        setupShape()
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(popViewController), name: .backButtonTapped, object: nil)
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = view.safeAreaLayoutGuide.layoutFrame.size
            layout.invalidateLayout()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Setup Methods

    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor
    }

    private func setupCollection() {
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupControl() {
        view.addSubview(horizontalStack)

        let pagerStack = UIStackView()
        pagerStack.axis = .horizontal
        pagerStack.spacing = 5
        pagerStack.alignment = .center
        pagerStack.distribution = .fill

        for tag in 1...sliderData.count {
            let pager = UIView()
            pager.tag = tag
            pager.backgroundColor = Styles.Colors.appBlackColor
            pager.layer.cornerRadius = 5
            pager.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollToSlide(sender:))))
            pagers.append(pager)
            pagerStack.addArrangedSubview(pager)
        }

        horizontalStack.addArrangedSubview(pagerStack)
        horizontalStack.addArrangedSubview(nextPageButton)

        horizontalStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }

    private func setupShape() {
        currentPageIndex = 1 / CGFloat(sliderData.count)

        let nextStroke = UIBezierPath(arcCenter: CGPoint(x: 25.3, y: 25.3), radius: 23, startAngle: -(.pi / 2), endAngle: 5, clockwise: true)
        shape.path = nextStroke.cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = Styles.Colors.appBlackColor.cgColor
        shape.lineWidth = 4
        shape.lineCap = .round
        shape.strokeStart = 0
        shape.strokeEnd = 0

        nextPageButton.layer.addSublayer(shape)
    }

    // MARK: - Actions

    @objc private func nextSlide() {
        let nextIndex = min(currentSlide + 1, sliderData.count - 1)
        collectionView.scrollToItem(at: IndexPath(item: nextIndex, section: 0), at: .centeredHorizontally, animated: true)
    }

    @objc private func scrollToSlide(sender: UIGestureRecognizer) {
        if let index = sender.view?.tag {
            collectionView.scrollToItem(at: IndexPath(item: index - 1, section: 0), at: .centeredHorizontally, animated: true)
            currentSlide = index - 1
            updatePagers()
        }
    }
    
    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }



    // MARK: - Helpers

    private func updatePagers() {
        pagers.enumerated().forEach { index, page in
            let isSelected = index == currentSlide
            let targetWidth: CGFloat = isSelected ? 20 : 10

            page.constraints.forEach { constraint in
                if constraint.firstAttribute == .width {
                    page.removeConstraint(constraint)
                }
            }

            UIView.animate(withDuration: 0.3) {
                page.layer.opacity = isSelected ? 1 : 0.5
                page.snp.remakeConstraints { make in
                    make.height.equalTo(10)
                    make.width.equalTo(targetWidth)
                }
                page.layoutIfNeeded()
            }
        }

        updateProgressBar()
    }

    private func updateProgressBar() {
        let progress = CGFloat(currentSlide + 1) / CGFloat(sliderData.count)

        CATransaction.begin()
        CATransaction.setAnimationDuration(0.5)
        shape.strokeEnd = progress
        CATransaction.commit()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension NewStudentScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SliderCell else {
            return UICollectionViewCell()
        }

        let sliderItem = sliderData[indexPath.item]
        cell.configure(with: sliderItem, isLastSlide: indexPath.item == sliderData.count - 1, isFirstSlide: indexPath.item == 0, isSecondSlide: indexPath.item == 1)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentSlide = indexPath.item
        updatePagers()
    }
}

// MARK: - UIScrollViewDelegate

extension NewStudentScreenVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(collectionView.contentOffset.x / collectionView.frame.width)
        if currentSlide != pageIndex {
            currentSlide = pageIndex
            updatePagers()
        }
    }
}

