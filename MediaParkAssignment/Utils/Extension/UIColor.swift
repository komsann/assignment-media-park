//
//  UIColor.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//
import UIKit

extension UIColor {
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
    self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
  }
  
  class var primary: UIColor {
    return UIColor(r: 246, g: 143, b: 84, a: 1)
  }
}
