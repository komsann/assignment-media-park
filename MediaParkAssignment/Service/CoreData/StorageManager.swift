//
//  StorageManager.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 8/2/22.
//

import CoreData
import UIKit

final class StorageManager {
  private let dataManager = CoreDataManager(complectionBlock: {})
  
  func fetch(completion: @escaping (ArticleResponse?) -> Void) {
    
    let predicate = NSPredicate(
      format: "%K ==[c] %@",
      argumentArray: [
        Constants.Predicate.Identifier.Key,
        Constants.Predicate.Identifier.Value
      ]
    )
    
    dataManager.fetchOne(
      from: Constants.Entity.ArticleReponse,
      predict: predicate) { (response: ArticleListEntity?) in
        if let entity = response {
          let data = ArticleResponse(with: entity)
          completion(data)
        } else {
          completion(nil)
        }
      } failure: { _ in
        completion(nil)
      }
  }
  
  func saveOrUpdate(with article: ArticleResponse, completion: @escaping () -> Void) {
    remove {
      self.save(with: article, completion: completion)
    }
  }
  
  func save(with article: ArticleResponse, completion: @escaping () -> Void) {
    let entity = ArticleListEntity(context: dataManager.managerObjectContext)
    entity.construct(with: Constants.Predicate.Identifier.Value, response: article)

    article.articles.forEach {
      let articleEntity = ArticleEntity(context: dataManager.managerObjectContext)
      articleEntity.construct(with: $0)
      entity.addToArticles(articleEntity)
    }

    dataManager.save { _ in
      completion()
    }
  }
  
  func remove(completion: @escaping () -> Void) {
    dataManager.deleteAll(from: Constants.Entity.ArticleReponse) { error in
      if error == nil {
        completion()
      }
    }
  }
}
