//
//  UIView.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import UIKit

extension UIView {
  
  @discardableResult
  func fromNib<T: UIView>() -> T? {
    let xibName = String(describing: type(of: self))
    
    guard let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?[0] as? T else {
      // xib not loaded, or it's top view is of the wrong type
      return nil
    }
    self.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    
    return view
  }
  
  @objc class func instantiateFromNib() -> Self {
    return instantiateFromNib(viewType: self)
  }
  
  func setShadow(_ radius: CGFloat,
                 opacity: Float) {
    
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2)
    layer.shadowRadius = radius
    layer.shadowOpacity = opacity
  }
  
  func setCorner(_ radius: CGFloat,
                 borderWidth: CGFloat) {
    layer.cornerRadius = radius
    layer.borderColor = UIColor.gray.cgColor
    layer.borderWidth = borderWidth
    layer.masksToBounds = true
  }
}

private extension UIView {
  static func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
    // swiftlint:disable:next force_cast
    return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
  }
}
