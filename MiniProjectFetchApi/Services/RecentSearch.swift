//
//  RecentSearch.swift
//  MiniProjectFetchApi
//
//  Created by Ario Syahputra on 24/07/24.
//

import Foundation

class RecentSearchManager {
    private let recentSearchesKey = "recentSearches"
    
    static let shared = RecentSearchManager()
    
    private init() {}
    
    func saveSearch(_ searchText: String) {
        var searches = getRecentSearches()
        if !searches.contains(searchText) {
            searches.insert(searchText, at: 0) // Insert at the beginning
            if searches.count > 10 {
                searches.removeLast() // Keep only the most recent 10 searches
            }
            UserDefaults.standard.set(searches, forKey: recentSearchesKey)
        }
    }
    
    func getRecentSearches() -> [String] {
        return UserDefaults.standard.stringArray(forKey: recentSearchesKey) ?? []
    }
}

