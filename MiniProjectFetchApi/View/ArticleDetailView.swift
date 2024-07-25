//
//  ArticleDetailView.swift
//  MiniProjectFetchApi
//
//  Created by Ario Syahputra on 22/07/24.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: ArticleData

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(article.title)
                .font(.title)
                .fontWeight(.bold)

            Text(formatDate(article.publishedAt))
                .font(.subheadline)
                .foregroundColor(.gray)

            Text(summarize(article.summary))
                .font(.body)

            Spacer()
        }
        .padding()
        .navigationTitle("Article Detail")
    }

    func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMMM yyyy, HH:mm"
            return outputFormatter.string(from: date)
        }
        return dateString
    }

    func summarize(_ summary: String) -> String {
        if let firstSentence = summary.split(separator: ".").first {
            return String(firstSentence) + "."
        }
        return summary
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: ArticleData(id: 1, title: "Sample Title", url: "https://example.com", imageUrl: "https://example.com/image.jpg", newsSite: "Sample NewsSite", summary: "Sample summary.", publishedAt: "2024-04-16T16:00:00Z"))
    }
}





