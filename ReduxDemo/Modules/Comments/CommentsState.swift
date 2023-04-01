//
//  CommentsState.swift
//  ReduxDemo
//
//  Created by Hugues Telolahy on 01/04/2023.
//

import Foundation

struct CommentsState: Codable {
    let episodeId: UUID
    let comments: [Comment]
    let isLoading: Bool
    let selectedCommentId: UUID?
    let presentedUserProfileId: UUID?
    let newCommentText: String
}

extension CommentsState {

    enum Action: ActionProtocol {
        case fetchEpisodeComments(id: UUID)
        case didReceiveEpisodeComments([Comment], episodeId: UUID)
        case postComment(Comment)
        case updateNewCommentText(String)
    }

    static let reducer: Reducer<Self> = { state, action in
        switch action {
        case AppState.Action.showScreen(.userProfile(let id, let selectedCommentId)):
            return .init(
                episodeId: state.episodeId,
                comments: state.comments,
                isLoading: state.isLoading,
                selectedCommentId: selectedCommentId,
                presentedUserProfileId: id,
                newCommentText: state.newCommentText
            )
        case AppState.Action.dismissScreen(.userProfile(let id, _)) where id == state.presentedUserProfileId:
            return .init(
                episodeId: state.episodeId,
                comments: state.comments,
                isLoading: state.isLoading,
                selectedCommentId: nil,
                presentedUserProfileId: nil,
                newCommentText: state.newCommentText
            )
        case Action.fetchEpisodeComments(let id) where id == state.episodeId:
            return .init(
                episodeId: state.episodeId,
                comments: [],
                isLoading: true,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId,
                newCommentText: state.newCommentText
            )
        case Action.didReceiveEpisodeComments(let comments, let episodeId) where episodeId == state.episodeId:
            return .init(
                episodeId: state.episodeId,
                comments: comments,
                isLoading: false,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId,
                newCommentText: ""
            )
        case Action.postComment(let comment) where comment.episodeId == state.episodeId:
            return .init(
                episodeId: state.episodeId,
                comments: [comment] + state.comments,
                isLoading: state.isLoading,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId,
                newCommentText: ""
            )
        case Action.updateNewCommentText(let text):
            return .init(
                episodeId: state.episodeId,
                comments: state.comments,
                isLoading: state.isLoading,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId,
                newCommentText: text
            )
        default:
            return state
        }
    }
}

extension CommentsState {
    init(episodeId: UUID) {
        self.episodeId = episodeId
        comments = []
        isLoading = true
        selectedCommentId = nil
        presentedUserProfileId = nil
        newCommentText = ""
    }
}

