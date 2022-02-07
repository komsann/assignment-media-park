//
//  ArticleRequestBuilder.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import Alamofire

struct ArticleRequestBuilder: URLQueryRequestBuilderProtocol {
  var path: String {
    return "/top-headlines"
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var parameters: Parameters? {
    return ["token": "229ea34766a29964ef235fcb299f8587"]
  }
}

