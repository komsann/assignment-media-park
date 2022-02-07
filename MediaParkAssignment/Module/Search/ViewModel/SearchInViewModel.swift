//
//  SearchInViewModel.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

struct SearchInViewModel {
  let isOnTitle: Bool
  let isOnDescription: Bool
  let isOnContent: Bool
  
  
  var searchInStatus: String {
    let title = isOnTitle ? "Title" : ""
    let description = isOnDescription ? "Description" : ""
    let content = isOnContent ? "Content" : ""
    
    if isOnTitle && isOnDescription && isOnContent {
      return "All"
    }
    
    if !isOnTitle && !isOnDescription && !isOnContent {
      return "None"
    }
    
    return "\(title) \(description) \(content)"
  }
}
