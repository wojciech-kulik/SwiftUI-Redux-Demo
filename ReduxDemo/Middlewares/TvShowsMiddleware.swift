//
//  TvShowsMiddleware.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation
import Combine

final class TvShowsMiddleware {

    private let tvShowsRepository = TvShowsRepository()
    private let usersRepository = UsersRepository()
    private var searchDebouncer = CurrentValueSubject<String, Never>("")

    func middleware(state: AppState, action: ActionProtocol) -> AnyPublisher<ActionProtocol, Never> {
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
                .flatMap { self.tvShowsRepository.fetchUpcomingEpisodes(phrase: $0) }
                .map { HomeState.Action.didReceiveUpcomingEpisodes($0) }
                .ignoreError()
                .eraseToAnyPublisher()

        case EpisodeDetailsState.Action.fetchEpisodeDetails(let id):
            return tvShowsRepository
                .fetchEpisodeDetails(episodeId: id)
                .map { EpisodeDetailsState.Action.didReceiveEpisodeDetails($0) }
                .ignoreError()
                .eraseToAnyPublisher()
        case CommentsState.Action.fetchEpisodeComments(let id):
            return tvShowsRepository
                .fetchComments(episodeId: id)
                .map { CommentsState.Action.didReceiveEpisodeComments($0, episodeId: id) }
                .ignoreError()
                .eraseToAnyPublisher()
        case CommentsState.Action.postComment(let comment):
            return tvShowsRepository
                .postComment(comment)
                .map { NoOpAction() }
                .ignoreError()
                .eraseToAnyPublisher()
        case UserDetailsState.Action.fetchUserProfile(let userId):
            return Publishers.Zip(
                usersRepository.fetchUser(id: userId).ignoreError(),
                tvShowsRepository.fetchComments(userId: userId).ignoreError()
            )
            .map { UserDetailsState.Action.didReceiveUserProfile(user: $0, comments: $1) }
            .eraseToAnyPublisher()
        default:
            return Empty().eraseToAnyPublisher()
        }
    }
}
