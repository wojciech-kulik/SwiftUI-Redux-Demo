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
    private static let usersRepository = UsersRepository()
    private static var searchDebouncer = CurrentValueSubject<String, Never>("")

    static let tvShows: Middleware<AppState> = { state, action in
        switch action {
        case HomeState.Action.fetchUpcomingEpisodes:
            return tvShowsRepository
                .fetchUpcomingEpisodes()
                .map { HomeState.Action.didReceiveUpcomingEpisodes($0) }
                .ignoreError()
                .eraseToAnyPublisher()
        case HomeState.Action.filterEpisodes(let phrase):
            // Cancelling previous request
            searchDebouncer.send(completion: .finished)
            searchDebouncer = CurrentValueSubject<String, Never>(phrase)

            return searchDebouncer
                .debounce(for: phrase == "" ? 0.0 : 0.5, scheduler: RunLoop.main)
                .first()
                .flatMap { tvShowsRepository.fetchUpcomingEpisodes(phrase: $0) }
                .map { HomeState.Action.didReceiveUpcomingEpisodes($0) }
                .ignoreError()
                .eraseToAnyPublisher()

        case EpisodeDetailsState.Action.fetchEpisodeDetails(let id):
            return tvShowsRepository
                .fetchEpisodeDetails(episodeId: id)
                .map { EpisodeDetailsState.Action.didReceiveEpisodeDetails($0) }
                .ignoreError()
                .eraseToAnyPublisher()
        case Comments.Action.fetchEpisodeComments(let id):
            return tvShowsRepository
                .fetchComments(episodeId: id)
                .map { Comments.Action.didReceiveEpisodeComments($0, episodeId: id) }
                .ignoreError()
                .eraseToAnyPublisher()
        case Comments.Action.postComment(let comment):
            return tvShowsRepository
                .postComment(comment)
                .map { NoOpAction() }
                .ignoreError()
                .eraseToAnyPublisher()
        case UserDetails.Action.fetchUserProfile(let userId):
            return Publishers.Zip(
                usersRepository.fetchUser(id: userId).ignoreError(),
                tvShowsRepository.fetchComments(userId: userId).ignoreError()
            )
            .map { UserDetails.Action.didReceiveUserProfile(user: $0, comments: $1) }
            .eraseToAnyPublisher()
        default:
            return Empty().eraseToAnyPublisher()
        }
    }
}
