//
//  ArticleViewModel.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

final class ArticleViewModel {
  
  private let apiClient = ArticleAPIClient()
  private let storageManager = StorageManager()
  
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
    apiClient.getArticle { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let response):
        strongSelf.articles = response.articles
        strongSelf.storageManager.saveOrUpdate(with: response, completion: completion)
      case .failure:
        break
      }
    }
  }
  
  func search(filterVM: FilterViewModel,
              completion: @escaping () -> Void) {
    if !searchText.isEmpty {
      apiClient.search(with: searchText,
                       sortByRelevance: sortByRelevance,
                       filterVM: filterVM) { [weak self] result in
        guard let strongSelf = self else { return }
        switch result {
        case .success(let response):
          strongSelf.articles = response.articles
          strongSelf.title = "\(response.totalArticles) News"
          completion()
        case .failure:
          break
        }
      }
    }
  }
}
