//
//  UITableViewCell.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import UIKit

extension UITableViewCell {
  class func reuseIdentifier() -> String {
    return "\(self)"
  }

  class func nib() -> UINib {
    return UINib(nibName: reuseIdentifier(), bundle: nil)
  }
  
  class func registerNibCell(_ tableView: UITableView) {
    tableView.register(nib(), forCellReuseIdentifier: reuseIdentifier())
  }
}
