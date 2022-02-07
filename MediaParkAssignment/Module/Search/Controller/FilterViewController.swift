//
//  FilterViewController.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import UIKit
import DatePicker

protocol FilterViewControllerDelegate: AnyObject {
  func filterViewControllerDidApply(_ viewModel: FilterViewModel)
}

final class FilterViewController: UIViewController {
  
  @IBOutlet weak var clearButton: ClearBarButton!
  @IBOutlet weak var filterView: FilterView!
  @IBOutlet weak var applyButton: MainButton!
  @IBOutlet weak var backButton: BackButton!
  
  weak var delegate: FilterViewControllerDelegate?
  
  var viewModel: FilterViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAction()
    initializeData()
    navigationController?.isNavigationBarHidden = true
  }
  
  func initializeData() {
    filterView.update(vm: viewModel)
  }
  
  func setupAction() {
    filterView.fromDateDidTap = {
      let datePicker = DatePicker()
      datePicker.show(in: self)
      datePicker.setup(beginWith: self.viewModel.fromDate) { (selected, date) in
        if selected, let selectedDate = date {
          self.viewModel.fromDate = selectedDate
          self.filterView.update(vm: self.viewModel)
        }
      }
    }
    
    filterView.toDateDidTap = {
      let datePicker = DatePicker()
      datePicker.show(in: self)
      datePicker.setup(beginWith: self.viewModel.toDate) { (selected, date) in
        if selected, let selectedDate = date {
          self.viewModel.toDate = selectedDate
          self.filterView.update(vm: self.viewModel)
        }
      }
    }
    
    filterView.searchInDidTap = {
      let vc = UIStoryboard.search().instantiate(controller: SearchInViewController.self)
      vc.delegate = self
      self.navigationController?.pushViewController(vc, animated: true)
    }
    
    applyButton.actionDidTap = {
      self.delegate?.filterViewControllerDidApply(self.viewModel)
      self.navigationController?.popViewController(animated: true)
    }
    
    clearButton.actionDidTap = {
      self.viewModel = FilterViewModel()
      self.filterView.update(vm: self.viewModel)
    }
    
    backButton.actionDidTap = {
      self.navigationController?.popViewController(animated: true)
    }
  }
}

extension FilterViewController: SearchInViewControllerDelegate {
  func searchInViewControllerDidApply(_ vm: SearchInViewModel) {
    viewModel.searchIn = vm
    filterView.seachInContentLabel.text = vm.searchInStatus
  }
}
