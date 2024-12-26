//
//  NewsScreenVC.swift
//  mobile-application-for-students
//
//  Created by Егорио on 24.12.2024.
//

import UIKit
import SnapKit
import FirebaseFirestore

class NewsScreenVC: UIViewController {
    // Логотип и заголовок
    private let logoImage = AppImageView(imageName: "logo")
    private let titleBackground = BackgroundForComponents()
    private let titleLabel = AppLabel(
        text: "Новости и события",
        textColor: Styles.Colors.appWhiteColor,
        textAlignment: .center,
        fontSize: 16,
        fontWeight: .bold
    )

    // Таблица для отображения новостей
    private let tableView = UITableView()

    // Массив новостей
    private var newsItems: [NewsItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupTableView()
        fetchNewsData()
    }

    // Настройка UI
    private func setupUI() {
        view.backgroundColor = Styles.Colors.appWhiteColor
//        navigationController?.navigationBar.isTranslucent = false
        overrideUserInterfaceStyle = .light

        [
            logoImage,
            titleBackground,
            titleLabel,
            tableView
        ].forEach { view.addSubview($0) }
    }

    // Настройка констрейнтов
    private func setupConstraints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(40)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }

        titleBackground.snp.makeConstraints { make in
            make.leading.equalTo(logoImage.snp.trailing).offset(20)
            make.centerY.equalTo(logoImage)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleBackground)
            make.centerX.equalTo(titleBackground)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom) // Это важно
        }

    }

    // Настройка таблицы
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .none
        tableView.backgroundColor = Styles.Colors.appWhiteColor
    }

    // Загрузка данных из Firestore
    private func fetchNewsData() {
        let db = Firestore.firestore()
        db.collection("news").getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching news: \(error)")
                return
            }

            guard let documents = snapshot?.documents else { return }
            self.newsItems = documents.compactMap { doc -> NewsItem? in
                return try? doc.data(as: NewsItem.self)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        cell.configure(with: newsItems[indexPath.row])
        cell.isUserInteractionEnabled = false
        return cell
    }

}
