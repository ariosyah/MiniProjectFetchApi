//
//  RecentSearchView.swift
//  MiniProjectFetchApi
//
//  Created by Ario Syahputra on 22/07/24.
//

import SwiftUI

struct RecentSearchView: View {
    @State private var recentSearches: [String] = []

    var body: some View {
        List(recentSearches, id: \.self) { search in
            Text(search)
        }
        .navigationTitle("Recent Search")
        .onAppear {
            recentSearches = RecentSearchManager.shared.getRecentSearches()
        }
    }
}

#Preview {
    RecentSearchView()
}

