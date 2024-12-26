//
//  NewsItem.swift
//  mobile-application-for-students
//
//  Created by Егорио on 25.12.2024.
//

import Foundation

struct NewsItem: Codable {
    let newsImageURL: String
    let newsPublicationDate: String
    let newsSubtitle: String
    let newsTitle: String
}
