//
//  ShowView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct ShowView : View {
    var entry: TvShowEntry

    var posterView: some View {
        Image(entry.show?.cover ?? "")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: 120.0)
    }

    var headerView: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(entry.show?.title ?? "-")
                .minimumScaleFactor(0.5)
                .font(.headline)

            Text("Next episode: " +
                "\(entry.nextEpisode.number) of \(entry.episodesInSeason)")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }

    var timerView: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(entry.nextEpisode.releaseDate, style: .timer)
                .minimumScaleFactor(0.3)
                .foregroundColor(Color.yellow.opacity(0.9))
                .font(.title)

            Text(entry.nextEpisode.releaseDate, style: .date)
                .font(.footnote)
                .foregroundColor(.gray)
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
        .foregroundColor(.white)
        .lineLimit(1)
    }
}

struct ShowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShowView(entry: .mockGameOfThrones)
                .frame(width: .infinity, height: 170.0, alignment: .center)
        }
    }
}
