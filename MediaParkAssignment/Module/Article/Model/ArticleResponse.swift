//
//  ArticleResponse.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

struct ArticleResponse: Codable, Hashable {
  let totalArticles: Int
  let articles: [Article]
  
  init(with entity: ArticleListEntity) {
    totalArticles = Int(entity.total)
    
    let articles = entity.articles?.allObjects as? [ArticleEntity] ?? []
    self.articles = articles.compactMap {
      Article(with: $0)
    }
  }
}
