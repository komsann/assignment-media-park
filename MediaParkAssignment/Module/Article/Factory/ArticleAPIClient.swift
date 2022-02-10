//
//  ArticleAPIClient.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import Alamofire
import Foundation
import RxSwift

final class ArticleAPIClient {
  private let service = APICoreService()
  
  func getArticle() -> Observable<ArticleResponse> {
    Observable.create { observer -> Disposable in
      let builder = ArticleRequestBuilder()
      let parser = ArticleResponseParser(observer: observer)
      self.service.performRequest(requestBuilder: builder, reponseParser: parser)
      return Disposables.create()
    }
  }
  
  func search(with text: String,
              sortByRelevance: String,
              filterVM: FilterViewModel) -> Observable<ArticleResponse> {
    
    Observable.create { observer -> Disposable in
      let builder = SearchArticleRequestBuilder(
        searchText: text,
        fromDate: filterVM.fromDate,
        toDate: filterVM.toDate,
        searchIn: filterVM.searchIn.searchInStatus,
        sortByRelevance: sortByRelevance
      )
      let parser = ArticleResponseParser(observer: observer)
      self.service.performRequest(requestBuilder: builder, reponseParser: parser)
      return Disposables.create()
    }
    
//    let builder = SearchArticleRequestBuilder(
//      searchText: text,
//      fromDate: filterVM.fromDate,
//      toDate: filterVM.toDate,
//      searchIn: filterVM.searchIn.searchInStatus,
//      sortByRelevance: sortByRelevance
//    )
//    let parser = ArticleResponseParser(completion: completion)
//    service.performRequest(requestBuilder: builder, reponseParser: parser)
  }
}
