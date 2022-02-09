//
//  ArticleEntity+CoreDataClass.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 8/2/22.
//
//

import Foundation
import CoreData

@objc(ArticleEntity)
public class ArticleEntity: NSManagedObject {
  func construct(with article: Article) {
    title = article.title
    des = article.description
    url = article.url
    image = article.image
    publishedAt = article.publishedAt
  }
}
