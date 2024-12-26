//
//  NewsCell.swift
//  mobile-application-for-students
//
//  Created by Егорио on 26.12.2024.
//

import UIKit
import SnapKit

class NewsCell: UITableViewCell {
    static let identifier = "NewsCell"

    private let newsBackground = UIView()
    private let newsImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true

        newsBackground.backgroundColor = Styles.Colors.appBlackColor
        newsBackground.layer.cornerRadius = 16

        [newsBackground, newsImageView, titleLabel, subtitleLabel, dateLabel].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        newsBackground.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10) // Отступ сверху ячейки
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10) // Отступ снизу ячейки
        }
        
        newsImageView.snp.makeConstraints { make in
            make.top.equalTo(newsBackground.snp.top).offset(20)
            make.leading.trailing.equalTo(newsBackground).inset(20)
            make.height.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(newsBackground).inset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(newsBackground).inset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(newsBackground).inset(20)
            make.bottom.equalTo(newsBackground.snp.bottom).inset(20)
        }
    }


    func configure(with newsItem: NewsItem) {
        titleLabel.text = newsItem.newsTitle
        subtitleLabel.text = newsItem.newsSubtitle
        dateLabel.text = newsItem.newsPublicationDate

        if let url = URL(string: newsItem.newsImageURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.newsImageView.image = image
                    }
                }
            }
        }
    }
}

