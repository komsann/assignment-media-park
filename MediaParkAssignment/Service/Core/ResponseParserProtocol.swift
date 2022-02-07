//
//  ResponseParserProtocol.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//
import Alamofire

enum DataResponseType {
  case json
  case data
  case empty
}

protocol ExpectedResponseType {
  var dataResponseType: DataResponseType { get }
}

extension ExpectedResponseType {
  var dataResponseType: DataResponseType {
    return .data
  }
}

protocol ExpectedResponseTypeData: ExpectedResponseType {}

extension ExpectedResponseTypeData {
  var dataResponseType: DataResponseType {
    return .data
  }
}

protocol ResponseParserProtocol: ExpectedResponseType {
  func parse(data: Data)
  func handleError(error: Error)
  func handleInvalidResponse(_ response: Data, error: Error?)
}
