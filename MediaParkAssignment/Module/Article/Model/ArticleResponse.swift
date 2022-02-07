//
//  ArticleResponse.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

struct ArticleResponse: Codable, Hashable {
  let articles: [Article]
  let totalArticles: Int
}
