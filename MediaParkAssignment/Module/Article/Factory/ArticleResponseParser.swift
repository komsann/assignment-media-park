//
//  ArticleResponseParser.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import Alamofire
import RxSwift

struct ArticleResponseParser {
  let observer: AnyObserver<ArticleResponse>
}

extension ArticleResponseParser: ResponseParserProtocol {
  func parse(data: Data) {
    do {
      let response = try JSONDecoder().decode(ArticleResponse.self, from: data)
      observer.onNext(response)
      observer.onCompleted()
    } catch {
      observer.onError(error)
    }
  }
  
  func handleError(error: Error) {
    observer.onError(error)
  }
  
  func handleInvalidResponse(_ response: Data, error: Error?) {}
}
