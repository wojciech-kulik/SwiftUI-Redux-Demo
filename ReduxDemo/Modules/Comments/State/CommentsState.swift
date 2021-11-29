//
//  CommentsState.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 29/11/2021.
//

import Foundation

struct CommentsState: Codable {
    let episodeId: UUID
    let comments: [Comment]
    let isLoading: Bool
    let selectedCommentId: UUID?
    let presentedUserProfileId: UUID?
}

extension CommentsState {
    init(episodeId: UUID) {
        self.episodeId = episodeId
        comments = []
        isLoading = true
        selectedCommentId = nil
        presentedUserProfileId = nil
    }
}
