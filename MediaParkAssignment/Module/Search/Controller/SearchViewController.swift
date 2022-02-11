//
//  SearchViewController.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var searchHeaderView: SearchHeaderView! {
    didSet {
      searchHeaderView.setCorner(25.0, borderWidth: 0.0)
    }
  }
  
  @IBOutlet weak var stackView: UIStackView!
  
  private var tableView = UITableView()
  
  private let disposeBag = DisposeBag()
  private let headerView = ArticleHeaderView()
  var articleViewModel: ArticleViewModel = ArticleViewModel()
  var filterViewModel: FilterViewModel = FilterViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAction()
    setupView()
    setupSearch()
    dataBinding()
  }
  
  func setupView() {
    setupTableView()
    navigationController?.isNavigationBarHidden = true
  }
  
  func setupTableView() {
    tableView.rx.setDelegate(self).disposed(by: disposeBag)
    tableView.register(nibCell: ArticleViewCell.self)
    tableView.backgroundColor = .secondaryBg
    stackView.addArrangedSubview(tableView)
    
    headerView.setTitle(articleViewModel.title)
    headerView.frame.size.height = 80
    tableView.tableHeaderView = headerView
    tableViewSelection()
  }
  
  func setupSearch() {
    searchHeaderView
      .searchBarTextField
      .rx
      .text
      .orEmpty
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .subscribe(onNext: { [weak self] text in
        guard let strongSelf = self else { return }
        strongSelf.articleViewModel.searchText = text
        strongSelf.performSearch(with: text)
      }).disposed(by: disposeBag)
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
  }
  
  func dataBinding() {
    articleViewModel
      .articles
      .map {
        $0.sorted {
          if let lhs = $0.publishedAt.toDate,
             let rhs = $1.publishedAt.toDate {
            return lhs > rhs
          }
          return false
        }
      }
      .bind(
        to: tableView
          .rx
          .items(
            cellIdentifier: ArticleViewCell.reuseIdentifier(),
            cellType: ArticleViewCell.self
          )
      ) { row, item, cell in
        cell.update(with: item)
      }.disposed(by: disposeBag)
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
  
  func tableViewSelection() {
    tableView.rx.modelSelected(Article.self).subscribe { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .next(let article):
        let vc = UIStoryboard.webView().instantiate(controller: WebViewController.self)
        vc.urlstring = article.url
        strongSelf.navigationController?.pushViewController(vc, animated: true)
      case .completed:
        break
      case .error(_):
        break
      }
    }.disposed(by: disposeBag)
  }
}

// MARK: - FilterViewControllerDelegate
extension SearchViewController: FilterViewControllerDelegate {
  func filterViewControllerDidApply(_ viewModel: FilterViewModel) {
    self.filterViewModel = viewModel
    performSearch(with: self.articleViewModel.searchText)
  }
}
