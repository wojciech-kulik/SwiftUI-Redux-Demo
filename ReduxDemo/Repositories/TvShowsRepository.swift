//
//  TvShowsRepository.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation
import Combine

enum TvShowsRepositoryError: Error {
    case unknown
    case couldNotFind
}

final class TvShowsRepository: ObservableObject {
    private var comments = Comment.allMocks

    func fetchUpcomingEpisodes() -> AnyPublisher<[UpcomingEpisode], TvShowsRepositoryError> {
        Just([UpcomingEpisode.mockGameOfThrones, .mockBreakingBad].sorted(by: { $0.releaseDate < $1.releaseDate }))
            .delay(for: 1.5, scheduler: DispatchQueue.main)
            .setFailureType(to: TvShowsRepositoryError.self)
            .eraseToAnyPublisher()
    }

    func fetchEpisodeDetails(episodeId: UUID) -> AnyPublisher<EpisodeDetails, TvShowsRepositoryError> {
        if let episode = EpisodeDetails.allMocks.first(where: { $0.id == episodeId }) {
            return Just(episode)
                .delay(for: 1.5, scheduler: DispatchQueue.main)
                .setFailureType(to: TvShowsRepositoryError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: TvShowsRepositoryError.couldNotFind)
                .delay(for: 2.0, scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }

    func fetchComments(episodeId: UUID) -> AnyPublisher<[Comment], TvShowsRepositoryError> {
        let comments = comments.filter({ $0.episodeId == episodeId })

        if !comments.isEmpty {
            return Just(comments.sorted(by: { $0.date > $1.date }))
                .delay(for: 1.5, scheduler: DispatchQueue.main)
                .setFailureType(to: TvShowsRepositoryError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: TvShowsRepositoryError.couldNotFind)
                .delay(for: 2.0, scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }

    func fetchComments(userId: UUID) -> AnyPublisher<[Comment], TvShowsRepositoryError> {
        let comments = comments.filter { $0.userId == userId }

        return Just(comments.sorted(by: { $0.date > $1.date }))
            .delay(for: 1.5, scheduler: DispatchQueue.main)
            .setFailureType(to: TvShowsRepositoryError.self)
            .eraseToAnyPublisher()
    }

    func postComment(_ comment: Comment) -> AnyPublisher<Void, TvShowsRepositoryError> {
        comments.append(comment)

        return Empty()
            .delay(for: 1.5, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
