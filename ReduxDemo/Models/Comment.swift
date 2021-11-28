//
//  Comment.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct Comment {
    let userId: UUID
    let avatar: String
    let name: String
    let date: Date
    let text: String
    let episodeId: UUID
}

extension Comment {
    static let mock = Comment(
        userId: User.mock.id,
        avatar: User.mock.avatar,
        name: User.mock.name,
        date: Date().addingTimeInterval(-3600),
        text: "Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ",
        episodeId: EpisodeDetails.mockBreakingBad.id
    )

    static let allMocks = [
        Comment(
            userId: User.mock.id,
            avatar: User.mock.avatar,
            name: User.mock.name,
            date: Date().addingTimeInterval(-3600),
            text: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum ",
            episodeId: EpisodeDetails.mockGameOfThrones.id
        ),
        Comment(
            userId: User.mock2.id,
            avatar: User.mock2.avatar,
            name: User.mock2.name,
            date: Date().addingTimeInterval(-7500),
            text: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum",
            episodeId: EpisodeDetails.mockGameOfThrones.id
        ),
        Comment(
            userId: User.mock.id,
            avatar: User.mock.avatar,
            name: User.mock.name,
            date: Date().addingTimeInterval(-8500),
            text: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum",
            episodeId: EpisodeDetails.mockGameOfThrones.id
        ),

        Comment(
            userId: User.mock2.id,
            avatar: User.mock2.avatar,
            name: User.mock2.name,
            date: Date().addingTimeInterval(-3600),
            text: "Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ",
            episodeId: EpisodeDetails.mockBreakingBad.id
        ),
        Comment(
            userId: User.mock.id,
            avatar: User.mock.avatar,
            name: User.mock.name,
            date: Date().addingTimeInterval(-7500),
            text: "Lorem Lorem Lorem",
            episodeId: EpisodeDetails.mockBreakingBad.id
        ),
        Comment(
            userId: User.mock2.id,
            avatar: User.mock2.avatar,
            name: User.mock2.name,
            date: Date().addingTimeInterval(-8500),
            text: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum",
            episodeId: EpisodeDetails.mockBreakingBad.id
        ),
    ]
}
