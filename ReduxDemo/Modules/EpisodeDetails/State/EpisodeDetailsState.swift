//
//  EpisodeDetailsState.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct EpisodeDetailsState: Codable {
    let episodeId: UUID
    let details: EpisodeDetails?
    let comments: CommentsState
    let isLoading: Bool
}

extension EpisodeDetailsState {
    init(id: UUID) {
        episodeId = id
        details = nil
        comments = CommentsState(episodeId: id)
        isLoading = true
    }
}
