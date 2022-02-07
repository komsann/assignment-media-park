//
//  SortByButton.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import UIKit

class SortByButton: UIView {
  
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var imgView: UIImageView!
  
  var isSelected: Bool = false {
    didSet {
      if isSelected {
        imgView.image = UIImage(named: "ic_sortBy_selected")
        backgroundView.backgroundColor = .primary
      } else {
        imgView.image = UIImage(named: "ic_sortBy")
        backgroundView.backgroundColor = .secondarySystemBackground
      }
    }
  }
  
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
    backgroundView.backgroundColor = .secondarySystemBackground
    addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(actionButton(_:))
    ))
  }
  
  @IBAction
  func actionButton(_ sender: UITapGestureRecognizer) {
    isSelected.toggle()
    actionDidTap?()
  }
}
