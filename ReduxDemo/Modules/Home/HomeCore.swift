//
//  HomeCore.swift
//  ReduxDemo
//
//  Created by Hugues Telolahy on 01/04/2023.
//

import Foundation

struct Home {

    struct State: Codable {
        let upcomingEpisodes: [UpcomingEpisode]
        let isLoading: Bool
        let presentedEpisodeId: UUID?
        let searchText: String
    }

    enum Action: ActionProtocol {
        case fetchUpcomingEpisodes
        case didReceiveUpcomingEpisodes([UpcomingEpisode])
        case updateSearchText(String)
        case filterEpisodes(phrase: String)
    }

    static let reducer: Reducer<State> = { state, action in
        switch action {
        case AppState.Action.showScreen(.episode(let id)):
            return .init(
                upcomingEpisodes: state.upcomingEpisodes,
                isLoading: state.isLoading,
                presentedEpisodeId: id,
                searchText: state.searchText
            )
        case AppState.Action.dismissScreen(.episode(let id)) where id == state.presentedEpisodeId:
            return .init(
                upcomingEpisodes: state.upcomingEpisodes,
                isLoading: state.isLoading,
                presentedEpisodeId: nil,
                searchText: state.searchText
            )
        case Action.fetchUpcomingEpisodes:
            return .init(
                upcomingEpisodes: [],
                isLoading: true,
                presentedEpisodeId: state.presentedEpisodeId,
                searchText: state.searchText
            )
        case Action.didReceiveUpcomingEpisodes(let episodes):
            return .init(
                upcomingEpisodes: episodes,
                isLoading: false,
                presentedEpisodeId: state.presentedEpisodeId,
                searchText: state.searchText
            )
        case Action.filterEpisodes(let phrase),
            Action.updateSearchText(let phrase):
            return .init(
                upcomingEpisodes: state.upcomingEpisodes,
                isLoading: phrase != "",
                presentedEpisodeId: state.presentedEpisodeId,
                searchText: phrase
            )
        default:
            return state
        }
    }
}

extension Home.State {
    init() {
        upcomingEpisodes = []
        isLoading = true
        presentedEpisodeId = nil
        searchText = ""
    }
}
