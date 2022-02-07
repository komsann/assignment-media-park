//
//  ArticleAPIClient.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import Alamofire
import Foundation

final class ArticleAPIClient {
  private let service = APICoreService()
  
  func getArticle(completion: @escaping (Result<ArticleResponse>) -> Void) {
    let builder = ArticleRequestBuilder()
    let parser = ArticleResponseParser(completion: completion)
    service.performRequest(requestBuilder: builder, reponseParser: parser)
  }
  
  func search(with text: String,
              sortByRelevance: String,
              filterVM: FilterViewModel,
              completion: @escaping (Result<ArticleResponse>) -> Void) {
    
    let builder = SearchArticleRequestBuilder(
      searchText: text,
      fromDate: filterVM.fromDate,
      toDate: filterVM.toDate,
      searchIn: filterVM.searchIn.searchInStatus,
      sortByRelevance: sortByRelevance
    )
    let parser = ArticleResponseParser(completion: completion)
    service.performRequest(requestBuilder: builder, reponseParser: parser)
  }
}
