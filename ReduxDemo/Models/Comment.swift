//
//  Comment.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct Comment {
    let avatar: String
    let name: String
    let date: Date
    let text: String
    let episodeId: UUID
}

extension Comment {
    static let mock = Comment(
        avatar: "avatar",
        name: "John Snow",
        date: Date().addingTimeInterval(-3600),
        text: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum ",
        episodeId: EpisodeDetails.mockBreakingBad.id
    )
}
