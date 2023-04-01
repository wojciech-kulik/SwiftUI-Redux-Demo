//
//  UpcomingEpisodeView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct UpcomingEpisodeView : View {
    let episode: UpcomingEpisode

    var posterView: some View {
        Image(episode.show.cover)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: 120.0)
    }

    var headerView: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(episode.show.title)
                .minimumScaleFactor(0.5)
                .font(.headline)

            Text("Next episode: " +
                "\(episode.episode) of \(episode.episodesInSeason)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }

    var timerView: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            (episode.releaseDate < Date() ? Text("00:00:00") : Text(episode.releaseDate, style: .timer))
                .minimumScaleFactor(0.3)
                .foregroundColor(.yellow)
                .font(.title)

            Text(episode.releaseDate, style: .date)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }

    var body: some View {
        ZStack {
            Color(white: 0.1, opacity: 1.0).ignoresSafeArea()

            HStack {
                posterView

                VStack(alignment: .leading, spacing: 5) {
                    headerView
                    Spacer()
                    timerView
                    Spacer()
                }
                .padding(16)

                Spacer()
            }
        }
        .lineLimit(1)
    }
}

struct ShowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UpcomingEpisodeView(episode: .mockGameOfThrones)
                .frame(width: .infinity, height: 170.0, alignment: .center)
        }
    }
}
