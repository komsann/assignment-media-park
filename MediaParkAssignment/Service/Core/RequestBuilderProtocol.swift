//
//  RequestBuilderProtocol.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import Alamofire

protocol RequestBuilderProtocol {
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: Parameters? { get }
  var encoding: ParameterEncoding { get }
  var data: Data? { get }
}

protocol JSONRequestBuilderProtocol: RequestBuilderProtocol { }

extension JSONRequestBuilderProtocol {
  var method: HTTPMethod {
    return .get
  }
  
  var encoding: ParameterEncoding {
    return JSONEncoding.default
  }
  
  var parameters: Parameters? {
    return nil
  }
  
  var data: Data? {
    return nil
  }
}

protocol URLQueryRequestBuilderProtocol: RequestBuilderProtocol { }

extension URLQueryRequestBuilderProtocol {
  var method: HTTPMethod {
    return .get
  }
  
  var encoding: ParameterEncoding {
    return URLEncoding.default
  }
  
  var parameters: Parameters? {
    return nil
  }
  
  var data: Data? {
    return nil
  }
}

