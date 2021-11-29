//
//  EpisodeDetails.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct EpisodeDetails: Codable {
    let id: UUID
    let title: String
    let photo: String
    let episode: Int
    let season: Int
    let episodeDescription: String
    let releaseDate: Date
}

extension EpisodeDetails: CustomStringConvertible {
    var description: String { "EpisodeDetails(\(title))" }
}

extension EpisodeDetails {
    private static let ReleaseHourGot: TimeInterval = 88 * 3600
    private static let ReleaseHourBreakingBad: TimeInterval = 8 * 3600

    static let mockGameOfThrones = EpisodeDetails(
        id: UUID(),
        title: "Dark Wings, Dark Words",
        photo: "got_episode",
        episode: 2,
        season: 3,
        episodeDescription: "The title is an in-universe old saying about messenger ravens, referring to the fact that such urgently delivered messages are often bad news. In the episode, Robb Stark receives news of the death of Hoster Tully as well as the sack of Winterfell and the disappearances of Bran and Rickon.",
        releaseDate: Date().addingTimeInterval(ReleaseHourGot)
    )
    static let mockBreakingBad = EpisodeDetails(
        id: UUID(),
        title: "Open House",
        photo: "breaking_episode",
        episode: 3,
        season: 4,
        episodeDescription: "In the episode, Walter and Skyler advance their plans to buy a car wash as a front organization, while Jesse holds increasingly darker parties to distract from his guilt for having killed Gale. Meanwhile, Marie starts stealing to cope with the difficult recovery of her husband Hank, who is asked to offer his advice regarding Gale's murder investigation.",
        releaseDate: Date().addingTimeInterval(ReleaseHourBreakingBad)
    )

    static let allMocks = [Self.mockGameOfThrones, Self.mockBreakingBad]
}
