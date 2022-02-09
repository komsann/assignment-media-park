//
//  NewsViewController.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 1/2/22.
//

import UIKit

class NewsViewController: UIViewController {
  
  private let viewModel = ArticleViewModel()
  private let headerView = ArticleHeaderView()
  
  @IBOutlet weak var mainHeaderView: MainHeaderView! {
    didSet {
      mainHeaderView.setCorner(25.0, borderWidth: 0.0)
    }
  }
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(nibCell: ArticleViewCell.self)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initializeData()
    headerView.frame.size.height = 80
    tableView.tableHeaderView = headerView
    navigationController?.isNavigationBarHidden = true
  }
  
  func initializeData() {
    viewModel.synchronizeLocalStore {
      self.tableView.reloadData()
    }
    
    viewModel.fetchData {
      self.tableView.reloadData()
    }
  }
}

extension NewsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(cell: ArticleViewCell.self, at: indexPath)
    let data = viewModel.articles[indexPath.row]
    cell.update(with: data)
    return cell
  }
}

extension NewsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = UIStoryboard.webView().instantiate(controller: WebViewController.self)
    vc.urlstring = viewModel.articles[indexPath.row].url
    navigationController?.pushViewController(vc, animated: true)
  }
}

