//
//  Date.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import Foundation

extension Date {
  var toDisplayString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: self)
  }
  
  var toParam: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    return formatter.string(from: self)
  }
}

