//
//  EpisodeDetails.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct EpisodeDetails {
    let title: String
    let photo: String
    let episode: Int
    let season: Int
    let description: String
}

extension EpisodeDetails {
    static let mock = EpisodeDetails(
        title: "Dark Wings, Dark Words",
        photo: "got_episode",
        episode: 2,
        season: 3,
        description: "The title is an in-universe old saying about messenger ravens, referring to the fact that such urgently delivered messages are often bad news. In the episode, Robb Stark receives news of the death of Hoster Tully as well as the sack of Winterfell and the disappearances of Bran and Rickon."
    )
}
