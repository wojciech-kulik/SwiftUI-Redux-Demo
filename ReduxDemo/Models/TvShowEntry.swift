//
//  TvShowEntry.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct TvShowEntry {
    let date: Date
    let show: TvShow?
    let nextEpisode: Episode
    let episodesInSeason: Int
}

extension TvShowEntry {
    private static let ReleaseHourGot: TimeInterval = 16 * 3600
    private static let ReleaseHourBreakingBad: TimeInterval = 8 * 3600

    static var mockGameOfThrones = TvShowEntry(
        date: Date(),
        show: .mockGameOfThrones,
        nextEpisode: Episode(number: 2, releaseDate: Date().addingTimeInterval(ReleaseHourGot)),
        episodesInSeason: 10
    )

    static var mockBreakingBad = TvShowEntry(
        date: Date(),
        show: .mockBreakingBad,
        nextEpisode: Episode(number: 3, releaseDate: Date().addingTimeInterval(ReleaseHourBreakingBad)),
        episodesInSeason: 8
    )
}
