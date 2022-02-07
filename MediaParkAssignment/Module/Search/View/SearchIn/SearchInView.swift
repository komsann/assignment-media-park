//
//  SearchInView.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import UIKit

class SearchInView: UIView {
  @IBOutlet weak var titleSwitch: UISwitch!
  @IBOutlet weak var descriptionSwitch: UISwitch!
  @IBOutlet weak var contentSwitch: UISwitch!
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fromNib()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    fromNib()
  }
}
