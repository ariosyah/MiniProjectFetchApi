//
//  ContentView.swift
//  MiniProjectFetchApi
//
//  Created by Ario Syahputra on 22/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ArticleViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Articles")
                    .font(.headline)
                    .padding()

                // Search Field
                TextField("Search by title", text: $viewModel.searchText, onCommit: viewModel.performSearch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                HStack {
                    // Category Filter
                    Picker("Select Category", selection: $viewModel.selectedCategory) {
                        Text("All").tag(String?.none)
                        ForEach(viewModel.categories.sorted(), id: \.self) { category in
                            Text(category).tag(String?.some(category))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)
                    .onChange(of: viewModel.selectedCategory) { _ in
                        viewModel.filterArticles()
                    }

                    Spacer()

                    NavigationLink(destination: RecentSearchView()) {
                        Text("Recent Search")
                    }
                    .padding(.horizontal)
                }

                // Article List
                List(viewModel.filteredArticles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        HStack {
                            if let imageUrl = article.imageUrl, let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                         .aspectRatio(contentMode: .fit)
                                         .frame(width: 50, height: 50)
                                } placeholder: {
                                    ProgressView()
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            }
                            Text(article.title)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
