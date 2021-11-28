//
//  EpisodeDetailsReducer.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

extension EpisodeDetailsState {
    static let reducer: Reducer<Self> = { state, action in
        switch action {
        case ActiveScreensStateAction.showScreen(.userProfile(let id, let selectedCommentId)):
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: state.details,
                comments: state.comments,
                isLoading: state.isLoading,
                isLoadingComments: state.isLoadingComments,
                selectedCommentId: selectedCommentId,
                presentedUserProfileId: id
            )
        case ActiveScreensStateAction.dismissScreen(.userProfile(let id, _)) where id == state.presentedUserProfileId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: state.details,
                comments: state.comments,
                isLoading: state.isLoading,
                isLoadingComments: state.isLoadingComments,
                selectedCommentId: nil,
                presentedUserProfileId: nil
            )
        case EpisodeDetailsAction.fetchEpisodeComments(let id) where id == state.episodeId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: state.details,
                comments: [],
                isLoading: state.isLoading,
                isLoadingComments: true,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId
            )
        case EpisodeDetailsAction.receivedEpisodeComments(let comments, let episodeId) where episodeId == state.episodeId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: state.details,
                comments: comments,
                isLoading: state.isLoading,
                isLoadingComments: false,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId
            )
        case EpisodeDetailsAction.fetchEpisodeDetails(let id) where id == state.episodeId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: nil,
                comments: state.comments,
                isLoading: true,
                isLoadingComments: state.isLoadingComments,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId
            )
        case EpisodeDetailsAction.receivedEpisodeDetails(let details) where details.id == state.episodeId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: details,
                comments: state.comments,
                isLoading: false,
                isLoadingComments: state.isLoadingComments,
                selectedCommentId: state.selectedCommentId,
                presentedUserProfileId: state.presentedUserProfileId
            )
        default:
            return state
        }
    }
}
