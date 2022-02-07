//
//  MPA-UIStoryboard.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 1/2/22.
//

import UIKit

extension UIStoryboard {
  static func main() -> UIStoryboard {
    return UIStoryboard(name: Constants.Storyboards.Main, bundle: nil)
  }
  
  static func search() -> UIStoryboard {
    return UIStoryboard(name: Constants.Storyboards.Search, bundle: nil)
  }
  
  static func webView() -> UIStoryboard {
    return UIStoryboard(name: Constants.Storyboards.WebView, bundle: nil)
  }
  
  func instantiate<T: UIViewController>(controller: T.Type, identifier: String? = T.identifier()) -> T {
    return instantiateViewController(withIdentifier: identifier!) as! T
  }
}
