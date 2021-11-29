//
//  CommentsStateReducer.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 29/11/2021.
//

import Foundation

extension CommentsState {
    static let reducer: Reducer<CommentsState> = { state, action in
        switch action {
        case ActiveScreensStateAction.showScreen(.userProfile(let id, let selectedCommentId)):
            return CommentsState(
                episodeId: state.episodeId,
                comments: state.comments,
                isLoading: state.isLoading,
                selectedCommentId: selectedCommentId,
                presentedUserProfileId: id
            )
        case ActiveScreensStateAction.dismissScreen(.userProfile(let id, _)) where id == state.presentedUserProfileId:
            return CommentsState(
                episodeId: state.episodeId,
                comments: state.comments,
                isLoading: state.isLoading,
                selectedCommentId: nil,
                presentedUserProfileId: nil
            )
        case CommentsStateAction.fetchEpisodeComments(let id) where id == state.episodeId:
            return CommentsState(
                episodeId: state.episodeId,
                comments: [],
                isLoading: true,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId
            )
        case CommentsStateAction.receivedEpisodeComments(let comments, let episodeId) where episodeId == state.episodeId:
            return CommentsState(
                episodeId: state.episodeId,
                comments: comments,
                isLoading: false,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId
            )
        default:
            return state
        }
    }
}
