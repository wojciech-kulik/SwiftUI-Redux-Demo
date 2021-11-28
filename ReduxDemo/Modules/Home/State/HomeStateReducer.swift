//
//  HomeStateReducer.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

extension HomeState {
    static let reducer: Reducer<Self> = { state, action in
        switch action {
        case ActiveScreensStateAction.showScreen(.episode(let id)):
            return HomeState(
                upcomingEpisodes: state.upcomingEpisodes,
                isLoading: state.isLoading,
                presentedEpisodeId: id
            )
        case ActiveScreensStateAction.dismissScreen(.episode(let id)) where id == state.presentedEpisodeId:
            return HomeState(
                upcomingEpisodes: state.upcomingEpisodes,
                isLoading: state.isLoading,
                presentedEpisodeId: nil
            )
        case HomeStateAction.fetchUpcomingEpisodes:
            return HomeState(
                upcomingEpisodes: [],
                isLoading: true,
                presentedEpisodeId: state.presentedEpisodeId
            )
        case HomeStateAction.receivedUpcomingEpisodes(let episodes):
            return HomeState(
                upcomingEpisodes: episodes,
                isLoading: false,
                presentedEpisodeId: state.presentedEpisodeId
            )
        default:
            return state
        }
    }
}
