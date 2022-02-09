//
//  ArticleListEntity+CoreDataClass.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 8/2/22.
//
//

import Foundation
import CoreData

@objc(ArticleListEntity)
public class ArticleListEntity: NSManagedObject {
  func construct(with identifier: String,
                 response: ArticleResponse) {
    self.identifier = identifier
    total = Int64(response.totalArticles)
  }
}
