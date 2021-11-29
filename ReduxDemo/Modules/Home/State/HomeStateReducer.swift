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
                presentedEpisodeId: id,
                searchText: state.searchText
            )
        case ActiveScreensStateAction.dismissScreen(.episode(let id)) where id == state.presentedEpisodeId:
            return HomeState(
                upcomingEpisodes: state.upcomingEpisodes,
                isLoading: state.isLoading,
                presentedEpisodeId: nil,
                searchText: state.searchText
            )
        case HomeStateAction.fetchUpcomingEpisodes:
            return HomeState(
                upcomingEpisodes: [],
                isLoading: true,
                presentedEpisodeId: state.presentedEpisodeId,
                searchText: state.searchText
            )
        case HomeStateAction.receivedUpcomingEpisodes(let episodes):
            return HomeState(
                upcomingEpisodes: episodes,
                isLoading: false,
                presentedEpisodeId: state.presentedEpisodeId,
                searchText: state.searchText
            )
        case HomeStateAction.filterEpisodes(let phrase), HomeStateAction.updateSearchText(let phrase):
            return HomeState(
                upcomingEpisodes: state.upcomingEpisodes,
                isLoading: true,
                presentedEpisodeId: state.presentedEpisodeId,
                searchText: phrase
            )
        default:
            return state
        }
    }
}
