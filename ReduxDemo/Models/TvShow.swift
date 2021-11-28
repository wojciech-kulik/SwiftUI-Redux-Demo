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
}

extension TvShow {
    static let mockGameOfThrones = TvShow(
        id: "1",
        title: "Game of Thrones",
        cover: "got"
    )

    static let mockBreakingBad = TvShow(
        id: "2",
        title: "Breaking Bad",
        cover: "breaking_bad"
    )
}
