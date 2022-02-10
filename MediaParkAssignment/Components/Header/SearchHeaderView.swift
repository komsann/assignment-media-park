//
//  SearchHeaderView.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import UIKit

class SearchHeaderView: UIView {
  @IBOutlet weak var searchView: UIView!
  @IBOutlet weak var searchStackView: UIStackView!
  @IBOutlet weak var filterView: UIView!
  @IBOutlet weak var sortByView: SortByButton!
  
  let searchBarTextField = UITextField()
  
  var filterDidTap: (() -> Void)?
  var sortByDidTap: (() -> Void)?
  
  var textFieldDidChanged: ((String) -> Void)?
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fromNib()
    setupView()
    setupAction()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    fromNib()
    setupView()
    setupAction()
  }
  
  func setupView() {
    setCorner(25.0, borderWidth: 1.0)
    setShadow(30, opacity: 0.6)
    customizeSearchView()
    setupSearchBar()
  }
  
  func setupSearchBar() {
    searchBarTextField.placeholder = "Search"
    searchBarTextField.borderStyle = .none
    searchStackView.addArrangedSubview(searchBarTextField)
  }
  
  func setupAction() {
    filterView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(filterAction(_:))
    ))
    
    sortByView.actionDidTap = {
      self.sortByDidTap?()
    }
  }
  
  func customizeSearchView() {
    [searchView, filterView, sortByView].forEach {
      $0.setCorner(
        searchView.bounds.height / 2,
        borderWidth: 0
      )
    }
  }
  
  
  @IBAction
  func filterAction(_ sender: UITapGestureRecognizer) {
    filterDidTap?()
  }
}
