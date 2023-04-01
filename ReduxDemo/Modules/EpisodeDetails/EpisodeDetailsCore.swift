//
//  EpisodeDetailsCore.swift
//  ReduxDemo
//
//  Created by Hugues Telolahy on 01/04/2023.
//

import Foundation

struct EpisodeDetailsFeature {

    struct State: Codable {
        let episodeId: UUID
        let details: EpisodeDetails?
        let comments: Comments.State
        let isLoading: Bool
    }

    enum Action: ActionProtocol {
        case fetchEpisodeDetails(id: UUID)
        case didReceiveEpisodeDetails(EpisodeDetails)
    }

    static let reducer: Reducer<State> = { state, action in
        switch action {
        case Action.fetchEpisodeDetails(let id) where id == state.episodeId:
            return .init(
                episodeId: state.episodeId,
                details: nil,
                comments: Comments.reducer(state.comments, action),
                isLoading: true
            )
        case Action.didReceiveEpisodeDetails(let details) where details.id == state.episodeId:
            return .init(
                episodeId: state.episodeId,
                details: details,
                comments: Comments.reducer(state.comments, action),
                isLoading: false
            )
        default:
            return .init(
                episodeId: state.episodeId,
                details: state.details,
                comments: Comments.reducer(state.comments, action),
                isLoading: state.isLoading
            )
        }
    }
}

extension EpisodeDetailsFeature.State {
    init(id: UUID) {
        episodeId = id
        details = nil
        comments = .init(episodeId: id)
        isLoading = true
    }
}
