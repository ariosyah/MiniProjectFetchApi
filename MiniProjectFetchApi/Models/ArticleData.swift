//
//  ArtcleApi.swift
//  MiniProjectFetchApi
//
//  Created by Ario Syahputra on 22/07/24.
//

import Foundation

struct ArticleData: Decodable, Identifiable {
    let id: Int
    let title: String
    let url: String
    let imageUrl: String? 
    let newsSite: String
    let summary: String
    let publishedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case imageUrl = "image_url"
        case newsSite = "news_site"
        case summary
        case publishedAt = "published_at"
    }
}

struct ArticleResponse: Decodable {
    let results: [ArticleData]
}

