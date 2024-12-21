//
//  NewStudentScreen.swift
//  mobile-application-for-students
//
//  Created by Егорио on 20.12.2024.
//

import UIKit
import SnapKit

class NewStudentScreenVC: UIViewController {
    
    private let sliderData: [ItemSlider] = [
        ItemSlider(color: Styles.Colors.appWhiteColor, title: "Мы одна большая музыкальная семья", subtitle: "Вместе мы создаём гармонию, поддерживаем друг друга и вдохновляем на новые свершения. Здесь каждый найдёт своё место.", imageName: ""),
        ItemSlider(color: Styles.Colors.appWhiteColor, title: "Твоя мечта, наша поддержка", subtitle: "Как в настоящей семье, мы всегда рядом: помогаем, учим и радуемся твоим успехам. Каждый аккорд — шаг к твоему будущему.", imageName: ""),
        ItemSlider(color: Styles.Colors.appWhiteColor, title: "Общая цель — общее счастье", subtitle: "Мы верим, что музыка объединяет. Вместе с тобой мы строим сообщество, где каждый важен и ценен.", imageName: "")
    ]
    
    lazy var collectionView: UICollectionView = {
        
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
        
        return collection
        
    }()
    
    private var pagers: [UIView] = []
    private var currentSlide = 0
    private var widthAnchor: NSLayoutConstraint?
    
    lazy var horizontalStack: UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 0
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    lazy var nextPageButton: UIView = {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextSlide))
       
        let nextImg = UIImageView()
        nextImg.image = UIImage(systemName: "chevron.right.circle.fill")
        nextImg.contentMode = .scaleAspectFit
        nextImg.tintColor = Styles.Colors.appBlackColor
        nextImg.translatesAutoresizingMaskIntoConstraints = false
        nextImg.widthAnchor.constraint(equalToConstant: 45).isActive = true
        nextImg.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        let button = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tapGesture)
        button.addSubview(nextImg)
        
        nextImg.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        nextImg.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollection()
        setupConstraints()
        setControll()
        
    }
    
    private func setControll() {
        // Добавляем horizontalStack на экран
        view.addSubview(horizontalStack)
        
        // Создаем pagerStack
        let pagerStack = UIStackView()
        pagerStack.axis = .horizontal
        pagerStack.spacing = 5
        pagerStack.alignment = .center
        pagerStack.distribution = .fill

        // Добавляем точки-индикаторы в pagerStack
        for tag in 1...sliderData.count {
            let pager = UIView()
            pager.tag = tag
            pager.backgroundColor = Styles.Colors.appBlackColor
            pager.layer.cornerRadius = 5
            pager.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollToSlide(sender: ))))
            self.pagers.append(pager)
            pagerStack.addArrangedSubview(pager)
        }

        // Добавляем pagerStack в horizontalStack
        horizontalStack.addArrangedSubview(pagerStack)
        horizontalStack.addArrangedSubview(nextPageButton)

        // Устанавливаем ограничения для horizontalStack
        horizontalStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }

    
    
    private func setupUI() {
        
        view.backgroundColor = Styles.Colors.appWhiteColor
        
    }
    
    private func setupCollection() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    @objc private func scrollToSlide(sender: UIGestureRecognizer) {
        if let index = sender.view?.tag {
            collectionView.scrollToItem(at: IndexPath(item: index - 1, section: 0), at: .centeredHorizontally, animated: true)
            currentSlide = index - 1
        }
    }

    @objc private func nextSlide() {
        
    }
    
}

extension NewStudentScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sliderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SliderCell {
            
            cell.contentView.backgroundColor = sliderData[indexPath.item].color
            cell.titleLabel.text = sliderData[indexPath.item].title
            cell.subtitleLabel.text = sliderData[indexPath.item].subtitle
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentSlide = indexPath.item
        
        pagers.forEach { page in
            let tag = page.tag
            let viewTag = indexPath.row + 1
            
            // Удаляем только нужные ограничения
            if let widthConstraint = page.constraints.first(where: { $0.firstAttribute == .width }) {
                page.removeConstraint(widthConstraint)
            }
            
            // Настраиваем вид и добавляем новые ограничения
            if viewTag == tag {
                UIView.animate(withDuration: 0.3) {page.layer.opacity = 1}
                widthAnchor = page.widthAnchor.constraint(equalToConstant: 20)
            } else {
                UIView.animate(withDuration: 0.3) {page.layer.opacity = 0.5}
                widthAnchor = page.widthAnchor.constraint(equalToConstant: 10)
            }
            widthAnchor?.isActive = true
            page.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
