//
//  ArticleHeaderView.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import UIKit

class ArticleHeaderView: UIView {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fromNib()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    fromNib()
  }
  
  func setTitle(_ title: String) {
    titleLabel.text = title
  }
}
