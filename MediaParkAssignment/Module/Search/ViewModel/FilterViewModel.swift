//
//  FilterViewModel.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import Foundation

final class FilterViewModel {
  var fromDate: Date?
  var toDate: Date?
  
  var searchIn = SearchInViewModel(
    isOnTitle: true,
    isOnDescription: true,
    isOnContent: true)
}
