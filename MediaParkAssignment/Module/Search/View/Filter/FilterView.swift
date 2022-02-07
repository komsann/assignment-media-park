//
//  FilterView.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import UIKit

class FilterView: UIView {
  
  @IBOutlet weak var fromDateView: UIView!
  @IBOutlet weak var toDateView: UIView!
  @IBOutlet weak var searchInView: UIView!
  
  @IBOutlet weak var fromDateTextField: UITextField!
  @IBOutlet weak var toDateTextField: UITextField!
  @IBOutlet weak var seachInContentLabel: UILabel!
  
  var fromDateDidTap: (() -> Void)?
  var toDateDidTap: (() -> Void)?
  var searchInDidTap: (() -> Void)?
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fromNib()
    setupAction()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    fromNib()
    setupAction()
  }
  
  func update(vm: FilterViewModel) {
    seachInContentLabel.text = vm.searchIn.searchInStatus
    
    if let fromDateString = vm.fromDate?.toDisplayString {
      fromDateTextField.text = fromDateString
    } else {
      fromDateTextField.text = ""
    }
    
    if let toDateString = vm.toDate?.toDisplayString {
      toDateTextField.text = toDateString
    } else {
      toDateTextField.text = ""
    }
  }
}

extension FilterView {
  func setupAction() {
    fromDateView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(fromDateAction(_:))
    ))
    
    toDateView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(toDateAction(_:))
    ))
    
    searchInView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(searchInAction(_:))
    ))
  }
  
  @IBAction
  func fromDateAction(_ sender: UITapGestureRecognizer) {
    fromDateDidTap?()
  }
  
  @IBAction
  func toDateAction(_ sender: UITapGestureRecognizer) {
    toDateDidTap?()
  }
  
  @IBAction
  func searchInAction(_ sender: UITapGestureRecognizer) {
    searchInDidTap?()
  }
}
