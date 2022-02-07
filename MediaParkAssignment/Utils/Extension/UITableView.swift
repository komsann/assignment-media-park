//
//  UITableView.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import UIKit

extension UITableView {
  func register<T: UITableViewCell>(nibCell: T.Type) {
    register(T.nib(), forCellReuseIdentifier: T.reuseIdentifier())
  }
  
  func dequeue<T: UITableViewCell>(cell: T.Type, at indexPath: IndexPath) -> T {
    // swiftlint:disable:next force_cast
    return dequeueReusableCell(withIdentifier: T.reuseIdentifier(), for: indexPath) as! T
  }
  
  func dequeue<T: UITableViewCell>(cell: T.Type) -> T {
    // swiftlint:disable:next force_cast
    return dequeueReusableCell(withIdentifier: T.reuseIdentifier()) as! T
  }
}
