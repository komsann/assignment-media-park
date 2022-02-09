//
//  Article.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

struct Article: Codable, Hashable {
  let title: String
  let description: String
  let url: String
  let image: String
  let publishedAt: String
  
  init(with entity: ArticleEntity) {
    title = entity.title ?? ""
    description = entity.des ?? ""
    url = entity.url ?? ""
    image = entity.image ?? ""
    publishedAt = entity.publishedAt ?? ""
  }
}
