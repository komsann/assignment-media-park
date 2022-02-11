//
//  NewsViewController.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 1/2/22.
//

import UIKit

import RxSwift
import RxCocoa

class NewsViewController: UIViewController, UIScrollViewDelegate {
  
  private let viewModel = ArticleViewModel()
  private let headerView = ArticleHeaderView()
  private let disposeBag = DisposeBag()
  
  @IBOutlet weak var mainHeaderView: MainHeaderView! {
    didSet {
      mainHeaderView.setCorner(25.0, borderWidth: 0.0)
    }
  }
  @IBOutlet weak var stackView: UIStackView!
  private var tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    initializeData()
    navigationController?.isNavigationBarHidden = true
  }
  
  func setupTableView() {
    tableView.rx.setDelegate(self).disposed(by: disposeBag)
    tableView.register(nibCell: ArticleViewCell.self)
    tableView.backgroundColor = .secondaryBg
    stackView.addArrangedSubview(tableView)
    
    headerView.frame.size.height = 80
    tableView.tableHeaderView = headerView
    tableViewSelection()
  }
  
  func initializeData() {
    viewModel.articles
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
    
    viewModel.synchronizeLocalStore {}
    viewModel.fetchData {}
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
