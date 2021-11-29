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
        case HomeStateAction.fetchUpcomingEpisodes:
            return tvShowsRepository
                .fetchUpcomingEpisodes()
                .map { HomeStateAction.receivedUpcomingEpisodes($0) }
                .ignoreError()
                .eraseToAnyPublisher()
        case HomeStateAction.filterEpisodes(let phrase):
            // Cancelling previous request
            searchDebouncer.send(completion: .finished)
            searchDebouncer = CurrentValueSubject<String, Never>(phrase)

            return searchDebouncer
                .debounce(for: phrase == "" ? 0.0 : 0.5, scheduler: DispatchQueue.main)
                .first()
                .flatMap { tvShowsRepository.fetchUpcomingEpisodes(phrase: $0) }
                .map { HomeStateAction.receivedUpcomingEpisodes($0) }
                .ignoreError()
                .eraseToAnyPublisher()

        case EpisodeDetailsAction.fetchEpisodeDetails(let id):
            return tvShowsRepository
                .fetchEpisodeDetails(episodeId: id)
                .map { EpisodeDetailsAction.receivedEpisodeDetails($0) }
                .ignoreError()
                .eraseToAnyPublisher()
        case CommentsStateAction.fetchEpisodeComments(let id):
            return tvShowsRepository
                .fetchComments(episodeId: id)
                .map { CommentsStateAction.receivedEpisodeComments($0, episodeId: id) }
                .ignoreError()
                .eraseToAnyPublisher()
        case CommentsStateAction.postComment(let comment):
            return tvShowsRepository
                .postComment(comment)
                .map { NoOpAction() }
                .ignoreError()
                .eraseToAnyPublisher()
        case UserDetailsStateAction.fetchUserProfile(let userId):
            return Publishers.Zip(
                usersRepository.fetchUser(id: userId).ignoreError(),
                tvShowsRepository.fetchComments(userId: userId).ignoreError()
            )
            .map { UserDetailsStateAction.receivedUserProfile(user: $0, comments: $1) }
            .eraseToAnyPublisher()
        default:
            return Empty().eraseToAnyPublisher()
        }
    }
}
