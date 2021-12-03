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
                presentedUserProfileId: id,
                newCommentText: state.newCommentText
            )
        case ActiveScreensStateAction.dismissScreen(.userProfile(let id, _)) where id == state.presentedUserProfileId:
            return CommentsState(
                episodeId: state.episodeId,
                comments: state.comments,
                isLoading: state.isLoading,
                selectedCommentId: nil,
                presentedUserProfileId: nil,
                newCommentText: state.newCommentText
            )
        case CommentsStateAction.fetchEpisodeComments(let id) where id == state.episodeId:
            return CommentsState(
                episodeId: state.episodeId,
                comments: [],
                isLoading: true,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId,
                newCommentText: state.newCommentText
            )
        case CommentsStateAction.didReceiveEpisodeComments(let comments, let episodeId) where episodeId == state.episodeId:
            return CommentsState(
                episodeId: state.episodeId,
                comments: comments,
                isLoading: false,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId,
                newCommentText: ""
            )
        case CommentsStateAction.postComment(let comment) where comment.episodeId == state.episodeId:
            return CommentsState(
                episodeId: state.episodeId,
                comments: [comment] + state.comments,
                isLoading: state.isLoading,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId,
                newCommentText: ""
            )
        case CommentsStateAction.updateNewCommentText(let text):
            return CommentsState(
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
