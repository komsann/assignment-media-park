//
//  ClearBarButton.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import UIKit

class ClearBarButton: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    fromNib()
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fromNib()
    setupView()
  }
  
  var actionDidTap:(() -> Void)?
  
  func setupView() {
    addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(actionButton(_:))
    ))
  }
  
  @IBAction
  func actionButton(_ sender: UITapGestureRecognizer) {
    actionDidTap?()
  }
}
