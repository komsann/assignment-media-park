//
//  String.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 9/2/22.
//

import Foundation

extension String {
  var toDate: Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    return formatter.date(from: self)
  }
}
