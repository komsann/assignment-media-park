//
//  MainButton.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import UIKit

class MainButton: UIView {
  @IBOutlet weak var mainButton: CornerButton!
  
  @IBInspectable
  var name: String = "" {
    didSet {
      mainButton.setTitle(name, for: .normal)
    }
  }
  
  var actionDidTap: (() -> Void)?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    fromNib()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fromNib()
  }
  
  @IBAction func buttonAction(_ sender: UIButton) {
    actionDidTap?()
  }
}
