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
    let nextEpisode: Episode?
    let isError: Bool
}

extension TvShowEntry {
    static func preview() -> TvShowEntry {
        return TvShowEntry(
            date: Date(),
            show: .previewGameOfThrones,
            nextEpisode: TvShow.previewGameOfThrones.nextEpisodes[0],
            isError: false
        )
    }

    static func preview2() -> TvShowEntry {
        return TvShowEntry(
            date: Date(),
            show: .previewBreakingBad,
            nextEpisode: TvShow.previewBreakingBad.nextEpisodes[0],
            isError: false
        )
    }

    static func error() -> TvShowEntry {
        return TvShowEntry(
            date: Date(),
            show: nil,
            nextEpisode: nil,
            isError: true
        )
    }
}
