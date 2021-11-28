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
    let comments: [Comment]
    let isLoading: Bool
    let isLoadingComments: Bool
    let presentedUserProfileId: UUID?
}

extension EpisodeDetailsState {
    init(id: UUID) {
        episodeId = id
        details = nil
        comments = []
        isLoading = true
        isLoadingComments = true
        presentedUserProfileId = nil
    }
}
