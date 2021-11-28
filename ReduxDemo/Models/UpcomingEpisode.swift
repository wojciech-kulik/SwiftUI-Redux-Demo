//
//  UpcomingEpisode.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct UpcomingEpisode: Codable, Identifiable {
    let id: UUID
    let releaseDate: Date
    let show: TvShow?
    let episode: Int
    let episodesInSeason: Int
}

extension UpcomingEpisode {
    private static let ReleaseHourGot: TimeInterval = 16 * 3600
    private static let ReleaseHourBreakingBad: TimeInterval = 8 * 3600

    static var mockGameOfThrones = UpcomingEpisode(
        id: EpisodeDetails.mockGameOfThrones.id,
        releaseDate: Date().addingTimeInterval(ReleaseHourGot),
        show: .mockGameOfThrones,
        episode: 2,
        episodesInSeason: 10
    )

    static var mockBreakingBad = UpcomingEpisode(
        id: EpisodeDetails.mockBreakingBad.id,
        releaseDate: Date().addingTimeInterval(ReleaseHourBreakingBad),
        show: .mockBreakingBad,
        episode: 3,
        episodesInSeason: 8
    )
}
