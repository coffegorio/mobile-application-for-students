//
//  NewStudentScreen.swift
//  mobile-application-for-students
//
//  Created by Егорио on 20.12.2024.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollection()
        setupConstraints()
        setupActions()
        
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
    
    private func setupActions() {
        
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
}
