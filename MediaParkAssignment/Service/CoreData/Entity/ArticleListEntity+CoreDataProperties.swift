//
//  ArticleListEntity+CoreDataProperties.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 9/2/22.
//
//

import Foundation
import CoreData

extension ArticleListEntity {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleListEntity> {
    return NSFetchRequest<ArticleListEntity>(entityName: "ArticleListEntity")
  }
  
  @NSManaged public var total: Int64
  @NSManaged public var identifier: String?
  @NSManaged public var articles: NSSet?
  
}

// MARK: Generated accessors for articles
extension ArticleListEntity {
  
  @objc(addArticlesObject:)
  @NSManaged public func addToArticles(_ value: ArticleEntity)
  
  @objc(removeArticlesObject:)
  @NSManaged public func removeFromArticles(_ value: ArticleEntity)
  
  @objc(addArticles:)
  @NSManaged public func addToArticles(_ values: NSSet)
  
  @objc(removeArticles:)
  @NSManaged public func removeFromArticles(_ values: NSSet)
  
}

extension ArticleListEntity : Identifiable {
  
}
