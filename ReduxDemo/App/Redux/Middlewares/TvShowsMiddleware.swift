//
//  TvShowsMiddleware.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation
import Combine

extension Middlewares {
    private static let tvShowsRepository = TvShowsRepository()

    static let tvShows: Middleware<AppState> = { state, action in
        switch action {
        case HomeStateAction.fetchUpcomingEpisodes:
            return tvShowsRepository
                .fetchUpcomingEpisodes()
                .map { HomeStateAction.receivedUpcomingEpisodes($0) }
                .catch { _ in Empty().eraseToAnyPublisher() }
                .eraseToAnyPublisher()
        case EpisodeDetailsAction.fetchEpisodeDetails(let id):
            return tvShowsRepository
                .fetchEpisodeDetails(episodeId: id)
                .map { EpisodeDetailsAction.receivedEpisodeDetails($0) }
                .catch { _ in Empty().eraseToAnyPublisher() }
                .eraseToAnyPublisher()
        default:
            return Empty().eraseToAnyPublisher()
        }
    }
}
