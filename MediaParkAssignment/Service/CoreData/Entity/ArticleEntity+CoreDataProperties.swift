//
//  ArticleEntity+CoreDataProperties.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 9/2/22.
//
//

import Foundation
import CoreData

extension ArticleEntity {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
    return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
  }
  
  @NSManaged public var des: String?
  @NSManaged public var image: String?
  @NSManaged public var title: String?
  @NSManaged public var url: String?
  @NSManaged public var publishedAt: String?
  @NSManaged public var article: ArticleListEntity?
  
}

extension ArticleEntity : Identifiable {
  
}
