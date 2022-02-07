//
//  APICoreService.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import Alamofire

protocol APICoreServiceProtocol {
  @discardableResult
  func performRequest(requestBuilder: RequestBuilderProtocol,
                      reponseParser: ResponseParserProtocol) -> DataRequest
  
}

final class APICoreService: APICoreServiceProtocol {
  @discardableResult
  func performRequest(
    requestBuilder: RequestBuilderProtocol,
    reponseParser: ResponseParserProtocol) -> DataRequest {
      
      let baseURL = URL(string: "https://gnews.io/api/v4")!
      let url = baseURL.appendingPathComponent(requestBuilder.path)
      
      
      let method = requestBuilder.method
      let parameters = requestBuilder.parameters
      let encoding = requestBuilder.encoding
      let networkManager = Alamofire.SessionManager.default
      
      let loader = ResponseLoader(requestBuilder: requestBuilder,
                                  reponseParser: reponseParser)
      
      let request = networkManager
        .request(url,
                 method: method,
                 parameters: parameters,
                 encoding: encoding)
        .validate()
      
      if reponseParser.dataResponseType == .data {
        request.responseData { response in
          loader.parse(response: response)
        }
      }
      
      return request
    }
}
