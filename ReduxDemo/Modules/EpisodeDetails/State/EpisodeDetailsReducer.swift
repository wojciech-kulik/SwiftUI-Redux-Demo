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
        case EpisodeDetailsStateAction.fetchEpisodeDetails(let id) where id == state.episodeId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: nil,
                comments: CommentsState.reducer(state.comments, action),
                isLoading: true
            )
        case EpisodeDetailsStateAction.didReceiveEpisodeDetails(let details) where details.id == state.episodeId:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: details,
                comments: CommentsState.reducer(state.comments, action),
                isLoading: false
            )
        default:
            return EpisodeDetailsState(
                episodeId: state.episodeId,
                details: state.details,
                comments: CommentsState.reducer(state.comments, action),
                isLoading: state.isLoading
            )
        }
    }
}
