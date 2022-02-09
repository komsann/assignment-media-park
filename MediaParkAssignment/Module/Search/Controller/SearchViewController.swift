//
//  SearchViewController.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import UIKit

class SearchViewController: UIViewController {
  @IBOutlet weak var searchHeaderView: SearchHeaderView! {
    didSet {
      searchHeaderView.setCorner(25.0, borderWidth: 0.0)
    }
  }
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.dataSource = self
      tableView.delegate = self
      tableView.register(nibCell: ArticleViewCell.self)
    }
  }
  
  private let headerView = ArticleHeaderView()
  var articleViewModel: ArticleViewModel = ArticleViewModel()
  var filterViewModel: FilterViewModel = FilterViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAction()
    setupView()
  }
  
  func setupView() {
    headerView.setTitle(articleViewModel.title)
    headerView.frame.size.height = 80
    tableView.tableHeaderView = headerView
    navigationController?.isNavigationBarHidden = true
  }
  
  func setupAction() {
    searchHeaderView.filterDidTap = {
      let vc = UIStoryboard.search().instantiate(controller: FilterViewController.self)
      vc.viewModel = self.filterViewModel
      vc.delegate = self
      self.navigationController?.pushViewController(vc, animated: true)
    }
    
    searchHeaderView.sortByDidTap = {
      self.articleViewModel.updateRelevance(
        isSortBySelected: self.searchHeaderView.sortByView.isSelected
      )
      self.performSearch(with: self.articleViewModel.searchText)
    }
    
    searchHeaderView.textFieldDidChanged = { [weak self] value in
      self?.articleViewModel.searchText = value
      self?.searching(value)
    }
  }
  
  
  func searching(_ searchText: String) {
    NSObject.cancelPreviousPerformRequests(withTarget: self)
    perform(#selector(performSearch(with:)), with: searchText, afterDelay: 0.5)
  }
  
  @objc
  func performSearch(with text: String) {
    articleViewModel.search(filterVM: filterViewModel) {
      self.updateData()
    }
  }
  
  func updateData() {
    headerView.setTitle(articleViewModel.title)
    tableView.reloadData()
  }
}

// MARK: - TableView
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articleViewModel.articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(cell: ArticleViewCell.self, at: indexPath)
    let vm = articleViewModel.articles[indexPath.row]
    cell.update(with: vm)
    return cell
  }
}

extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = UIStoryboard.webView().instantiate(controller: WebViewController.self)
    vc.urlstring = articleViewModel.articles[indexPath.row].url
    navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: - FilterViewControllerDelegate
extension SearchViewController: FilterViewControllerDelegate {
  func filterViewControllerDidApply(_ viewModel: FilterViewModel) {
    self.filterViewModel = viewModel
    performSearch(with: self.articleViewModel.searchText)
  }
}
