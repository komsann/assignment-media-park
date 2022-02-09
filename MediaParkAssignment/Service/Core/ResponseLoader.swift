//
//  ResponseLoader.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import Alamofire

struct ResponseLoader {
  let requestBuilder: RequestBuilderProtocol
  let reponseParser: ResponseParserProtocol
}

extension ResponseLoader {
  func parse(response: DataResponse<Data>) {
    switch response.result {
    case .success(let data):
      reponseParser.parse(data: data)
    case .failure(let error):
      debugError(with: error)
      reponseParser.handleError(error: error)
    }
  }
}

fileprivate extension ResponseLoader {
  func debugError(with error: Error) {
    debugPrint("⚠️ \(requestMessage) failed:\n" + "\(error)")
  }
  
  var requestMessage: String {
    if let parameters = requestBuilder.parameters {
      return " params: \(parameters)"
    }
    return " params: []"
  }
}
