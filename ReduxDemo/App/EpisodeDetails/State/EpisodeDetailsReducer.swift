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
        case ActiveScreensStateAction.showScreen(.userProfile(let id)):
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: state.details,
                comments: state.comments,
                isLoading: state.isLoading,
                isLoadingComments: state.isLoadingComments,
                presentedUserProfileId: id
            )
        case ActiveScreensStateAction.dismissScreen(.userProfile(let id)) where id == state.presentedUserProfileId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: state.details,
                comments: state.comments,
                isLoading: state.isLoading,
                isLoadingComments: state.isLoadingComments,
                presentedUserProfileId: nil
            )
        case EpisodeDetailsAction.fetchEpisodeComments(let id) where id == state.episodeId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: state.details,
                comments: [],
                isLoading: state.isLoading,
                isLoadingComments: true,
                presentedUserProfileId: state.presentedUserProfileId
            )
        case EpisodeDetailsAction.receivedEpisodeComments(let comments) where comments.isEmpty || comments[0].episodeId == state.episodeId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: state.details,
                comments: comments,
                isLoading: state.isLoading,
                isLoadingComments: false,
                presentedUserProfileId: state.presentedUserProfileId
            )
        case EpisodeDetailsAction.fetchEpisodeDetails(let id) where id == state.episodeId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: nil,
                comments: state.comments,
                isLoading: true,
                isLoadingComments: state.isLoadingComments,
                presentedUserProfileId: state.presentedUserProfileId
            )
        case EpisodeDetailsAction.receivedEpisodeDetails(let details) where details.id == state.episodeId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: details,
                comments: state.comments,
                isLoading: false,
                isLoadingComments: state.isLoadingComments,
                presentedUserProfileId: state.presentedUserProfileId
            )
        default:
            return state
        }
    }
}
