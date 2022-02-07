//
//  ArticleViewModel.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

final class ArticleViewModel {
  
  private let apiClient = ArticleAPIClient()
  
  var title: String = ""
  var searchText: String = ""
  var sortByRelevance: String = ""
  var articles: [Article] = []
  
  func updateRelevance(isSortBySelected: Bool) {
    sortByRelevance = isSortBySelected ? "relevance" : "publishedAt"
  }
  
  func fetchData(completion: @escaping () -> Void) {
    apiClient.getArticle { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let response):
        strongSelf.articles = response.articles
        completion()
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
