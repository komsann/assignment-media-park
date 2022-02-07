//
//  UIImageView.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import UIKit
import SDWebImage

extension UIImageView {
  func sd_setImage(with url: URL?) {
    let placeholder = UIImage(named: "img-placeholder")
    sd_setImage(with: url, placeholderImage: placeholder)
  }
}
