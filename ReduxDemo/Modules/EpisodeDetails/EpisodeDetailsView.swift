//
//  EpisodeDetailsView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct EpisodeDetailsView: View {
    let details: EpisodeDetails

    var headerView: some View {
        VStack(spacing: 0.0) {
            Image(details.photo)
                .resizable()
                .frame(height: 220)
                .aspectRatio(contentMode: .fill)

            Text(details.title)
                .font(.title)
                .padding()

            Text("S\(details.season, specifier: "%02d")E\(details.episode, specifier: "%02d") • \(details.releaseDate, format: .relative(presentation: .named))")
                .font(.subheadline)
                .foregroundColor(.yellow)
        }
    }

    @ViewBuilder
    var descriptionView: some View {
        Text("Description")
            .foregroundColor(.yellow)
            .padding(.top, 20.0)
            .padding(.vertical)

        Text(details.episodeDescription)
    }

    @ViewBuilder
    var commentsView: some View {
        Text("Comments")
            .foregroundColor(.yellow)
            .padding(.top, 20.0)
            .padding(.vertical)

        CommentsListView(episodeId: details.id)
    }

    var body: some View {
        UIScrollView.appearance().keyboardDismissMode = .onDrag

        return ScrollView {
            VStack(alignment: .leading, spacing: 0.0) {
                headerView
                descriptionView.padding(.horizontal, 24.0)
                commentsView.padding(.horizontal, 24.0)
            }
        }
        .ignoresSafeArea(edges: [.top])
    }
}

struct EpisodeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsView(details: .mockGameOfThrones)
    }
}
