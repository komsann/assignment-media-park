//
//  ArticleViewModel.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import RxSwift

final class ArticleViewModel {
  
  private let apiClient = ArticleAPIClient()
  private let storageManager = StorageManager()
  private let disposeBag = DisposeBag()
  
  var title: String = ""
  var searchText: String = ""
  var sortByRelevance: String = ""
  var articles: [Article] = [] {
    didSet {
      articles = articles.sorted {
        if let lhs = $0.publishedAt.toDate,
           let rhs = $1.publishedAt.toDate {
          return lhs > rhs
        }
        return false
      }
    }
  }
  
  func synchronizeLocalStore(completion: @escaping () -> Void) {
    storageManager.fetch { response in
      if let response = response {
        self.articles = response.articles
        completion()
      }
    }
  }
  
  func updateRelevance(isSortBySelected: Bool) {
    sortByRelevance = isSortBySelected ? "relevance" : "publishedAt"
  }
  
  func fetchData(completion: @escaping () -> Void) {
    apiClient.getArticle().subscribe { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .next(let response):
        strongSelf.articles = response.articles
        strongSelf.storageManager.saveOrUpdate(with: response, completion: completion)
      case .completed:
        completion()
      case .error(_):
        break
      }
    }.disposed(by: disposeBag)
  }
  
  func search(filterVM: FilterViewModel,
              completion: @escaping () -> Void) {
    if !searchText.isEmpty {
      apiClient
        .search(with: searchText,
                sortByRelevance: sortByRelevance,
                filterVM: filterVM)
        .subscribe { [weak self] result in
          guard let strongSelf = self else { return }
          switch result {
          case .next(let response):
            strongSelf.articles = response.articles
            strongSelf.title = "\(response.totalArticles) News"
          case .completed:
            completion()
          case .error(_):
            break
          }
        }.disposed(by: disposeBag)
    }
  }
}
