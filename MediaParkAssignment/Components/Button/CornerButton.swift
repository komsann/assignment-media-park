//
//  CornerButton.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import UIKit

@IBDesignable
class CornerButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  @IBInspectable
  var borderWidth: CGFloat = 0.0 {
    didSet {
      self.setCorner(23.0, borderWidth: borderWidth)
      
    }
  }
  
  @IBInspectable
  var borderColor: UIColor = .red {
    didSet {
      layer.borderColor = borderColor.cgColor
    }
  }
}

fileprivate extension CornerButton {
  func setupView() {
    setCorner(23.0, borderWidth: 0)
  }
}
