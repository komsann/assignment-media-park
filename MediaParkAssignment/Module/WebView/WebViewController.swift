//
//  WebViewController.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 7/2/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  @IBOutlet weak var backButton: BackButton!
  @IBOutlet weak var webView: WKWebView!
  
  var urlstring: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupAction()
  }
  
  func setupView() {
    let link = URL(string: urlstring)!
    let request = URLRequest(url: link)
    webView.load(request)
    navigationController?.isNavigationBarHidden = true
  }
  
  func setupAction() {
    backButton.actionDidTap = {
      self.navigationController?.popViewController(animated: true)
    }
  }
}
