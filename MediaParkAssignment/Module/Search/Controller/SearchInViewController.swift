//
//  SearchInViewController.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import UIKit

protocol SearchInViewControllerDelegate: AnyObject {
  func searchInViewControllerDidApply(_ vm: SearchInViewModel)
}

class SearchInViewController: UIViewController {
  
  @IBOutlet weak var searchInView: SearchInView!
  @IBOutlet weak var applyButton: MainButton!
  @IBOutlet weak var backButton: BackButton!
  @IBOutlet weak var clearBarButton: ClearBarButton!
  
  
  weak var delegate: SearchInViewControllerDelegate?
  
  var searchInViewModel: SearchInViewModel {
    return  SearchInViewModel(
      isOnTitle: searchInView.titleSwitch.isOn,
      isOnDescription: searchInView.descriptionSwitch.isOn,
      isOnContent: searchInView.contentSwitch.isOn
    )
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAction()
  }
  
  func setupAction() {
    applyButton.actionDidTap = {
      self.delegate?.searchInViewControllerDidApply(self.searchInViewModel)
      self.navigationController?.popViewController(animated: true)
    }
    
    clearBarButton.actionDidTap = {
      [self.searchInView.titleSwitch,
       self.searchInView.descriptionSwitch,
       self.searchInView.contentSwitch].forEach {
        $0?.isOn = true
      }
    }
    
    backButton.actionDidTap = {
      self.navigationController?.popViewController(animated: true)
    }
  }
}
