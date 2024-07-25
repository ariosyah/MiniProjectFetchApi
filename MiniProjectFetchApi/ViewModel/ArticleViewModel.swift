//
//  ArticleViewModel.swift
//  MiniProjectFetchApi
//
//  Created by Ario Syahputra on 24/07/24.
//

import Foundation
import Combine

class ArticleViewModel: ObservableObject {
    @Published var articles: [ArticleData] = []
    @Published var filteredArticles: [ArticleData] = []
    @Published var searchText: String = ""
    @Published var selectedCategory: String? = nil
    @Published var categories: Set<String> = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchArticles()
    }

    // Fetches articles from the API
    func fetchArticles() {
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v4/articles/") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ArticleResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching articles: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.articles = response.results
                self?.filteredArticles = response.results
                self?.categories = Set(response.results.map { $0.newsSite })
            })
            .store(in: &cancellables)
    }

    func performSearch() {
        RecentSearchManager.shared.saveSearch(searchText)
        filterArticles()
    }

    func filterArticles() {
        filteredArticles = articles
        if let selectedCategory = selectedCategory, !selectedCategory.isEmpty {
            filteredArticles = filteredArticles.filter { $0.newsSite == selectedCategory }
        }
        if !searchText.isEmpty {
            filteredArticles = filteredArticles.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}



