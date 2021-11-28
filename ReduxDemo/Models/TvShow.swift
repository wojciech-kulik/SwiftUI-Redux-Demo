//
//  TvShow.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct TvShow: Codable {
    let id: UUID
    let title: String
    let cover: String
}

extension TvShow {
    static let mockGameOfThrones = TvShow(
        id: UUID(),
        title: "Game of Thrones",
        cover: "got"
    )

    static let mockBreakingBad = TvShow(
        id: UUID(),
        title: "Breaking Bad",
        cover: "breaking_bad"
    )
}
