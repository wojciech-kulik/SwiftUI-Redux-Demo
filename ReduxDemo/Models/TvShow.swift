//
//  TvShow.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct Episode {
    let number: Int
    let releaseDate: Date
}

struct TvShow {
    let id: String
    let title: String
    let cover: String
    let nextEpisodes: [Episode]
    let episodesInSeason: Int
}

extension TvShow {
    private static let OneDay: TimeInterval = 24 * 3600
    private static let ReleaseHourGot: TimeInterval = 16 * 3600
    private static let ReleaseHourBreakingBad: TimeInterval = 8 * 3600

    static let previewGameOfThrones = TvShow(
        id: "1",
        title: "Game of Thrones",
        cover: "got",
        nextEpisodes: [
            Episode(number: 6, releaseDate: Date().addingTimeInterval(ReleaseHourGot)),
            Episode(number: 7, releaseDate: Date().addingTimeInterval(7 * OneDay + ReleaseHourGot)),
            Episode(number: 8, releaseDate: Date().addingTimeInterval(14 * OneDay + ReleaseHourGot))
        ],
        episodesInSeason: 10
    )

    static let previewBreakingBad = TvShow(
        id: "2",
        title: "Breaking Bad",
        cover: "breaking_bad",
        nextEpisodes: [
            Episode(number: 3, releaseDate: Date().addingTimeInterval(ReleaseHourBreakingBad)),
            Episode(number: 4, releaseDate: Date().addingTimeInterval(7 * OneDay + ReleaseHourBreakingBad)),
            Episode(number: 5, releaseDate: Date().addingTimeInterval(14 * OneDay + ReleaseHourBreakingBad))
        ],
        episodesInSeason: 8
    )
}
