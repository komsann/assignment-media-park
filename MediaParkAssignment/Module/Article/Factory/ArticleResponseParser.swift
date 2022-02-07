//
//  ArticleResponseParser.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import Alamofire

struct ArticleResponseParser {
  let completion: (Result<ArticleResponse>) -> Void
}

extension ArticleResponseParser: ResponseParserProtocol {
  func parse(data: Data) {
    do {
      let response = try JSONDecoder().decode(ArticleResponse.self, from: data)
      completion(Result<ArticleResponse>.success(response))
    } catch {
      debugPrint(error)
    }
  }
  
  func handleError(error: Error) {
    completion(Result<ArticleResponse>.failure(error))
  }
  
  func handleInvalidResponse(_ response: Data, error: Error?) {}
}
