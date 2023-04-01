//
//  EpisodeDetailsState.swift
//  ReduxDemo
//
//  Created by Hugues Telolahy on 01/04/2023.
//

import Foundation

struct EpisodeDetailsState: Codable {
    let episodeId: UUID
    let details: EpisodeDetails?
    let comments: CommentsState
    let isLoading: Bool
}

extension EpisodeDetailsState {

    enum Action: ActionProtocol {
        case fetchEpisodeDetails(id: UUID)
        case didReceiveEpisodeDetails(EpisodeDetails)
    }

    static let reducer: Reducer<Self> = { state, action in
        switch action {
        case Action.fetchEpisodeDetails(let id) where id == state.episodeId:
            return .init(
                episodeId: state.episodeId,
                details: nil,
                comments: CommentsState.reducer(state.comments, action),
                isLoading: true
            )
        case Action.didReceiveEpisodeDetails(let details) where details.id == state.episodeId:
            return .init(
                episodeId: state.episodeId,
                details: details,
                comments: CommentsState.reducer(state.comments, action),
                isLoading: false
            )
        default:
            return .init(
                episodeId: state.episodeId,
                details: state.details,
                comments: CommentsState.reducer(state.comments, action),
                isLoading: state.isLoading
            )
        }
    }
}

extension EpisodeDetailsState {
    init(id: UUID) {
        episodeId = id
        details = nil
        comments = .init(episodeId: id)
        isLoading = true
    }
}
