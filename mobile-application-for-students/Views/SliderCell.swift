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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSlide()
        setupConstraints() // Вызов метода для установки констрейнтов
    }
    
    private func setSlide() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(100) // Исправлено
            make.leading.equalTo(contentView.snp.leading).offset(40)
            make.trailing.equalTo(contentView.snp.trailing).inset(40)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(contentView.snp.leading).offset(40)
            make.trailing.equalTo(contentView.snp.trailing).inset(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
