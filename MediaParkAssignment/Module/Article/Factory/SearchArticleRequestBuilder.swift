//
//  SearchArticleRequestBuilder.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import Alamofire
import Foundation

struct SearchArticleRequestBuilder: URLQueryRequestBuilderProtocol {
  let searchText: String
  let fromDate: Date?
  let toDate: Date?
  let searchIn: String
  let sortByRelevance: String
  
  var path: String {
    return "/search"
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var parameters: Parameters? {
    
    var params =  [
      "token": "229ea34766a29964ef235fcb299f8587",
      "q": searchText,
      "in": searchIn,
      "sortBy": "publishedAt"
    ]
    
    if let fromDateString = fromDate?.toParam {
      params["from"] = fromDateString
    }
    
    if let toDateString = toDate?.toParam {
      params["to"] = toDateString
    }
    
    if !sortByRelevance.isEmpty {
      params["sortBy"] = sortByRelevance
    }

    return params
  }
}
