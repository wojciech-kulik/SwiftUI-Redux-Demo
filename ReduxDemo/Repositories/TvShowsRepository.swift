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
    private let simulatedDelay: RunLoop.SchedulerTimeType.Stride = 1.0

    private var comments = Comment.allMocks

    func fetchUpcomingEpisodes(phrase: String? = nil) -> AnyPublisher<[UpcomingEpisode], TvShowsRepositoryError> {
        let isFiltering = phrase != nil
        let phrase = phrase?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let episodes = [UpcomingEpisode.mockGameOfThrones, .mockBreakingBad]
            .filter { phrase == "" || $0.show.title.lowercased().contains(phrase) }
            .sorted(by: { $0.releaseDate < $1.releaseDate })

        return Just(episodes)
            .delay(for: isFiltering ? 0.0 : simulatedDelay, scheduler: RunLoop.main)
            .setFailureType(to: TvShowsRepositoryError.self)
            .eraseToAnyPublisher()
    }

    func fetchEpisodeDetails(episodeId: UUID) -> AnyPublisher<EpisodeDetails, TvShowsRepositoryError> {
        if let episode = EpisodeDetails.allMocks.first(where: { $0.id == episodeId }) {
            return Just(episode)
                .delay(for: simulatedDelay, scheduler: RunLoop.main)
                .setFailureType(to: TvShowsRepositoryError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: TvShowsRepositoryError.couldNotFind)
                .delay(for: simulatedDelay, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        }
    }

    func fetchComments(episodeId: UUID) -> AnyPublisher<[Comment], TvShowsRepositoryError> {
        let comments = comments.filter({ $0.episodeId == episodeId })

        if !comments.isEmpty {
            return Just(comments.sorted(by: { $0.date > $1.date }))
                .delay(for: simulatedDelay, scheduler: RunLoop.main)
                .setFailureType(to: TvShowsRepositoryError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: TvShowsRepositoryError.couldNotFind)
                .delay(for: simulatedDelay, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        }
    }

    func fetchComments(userId: UUID) -> AnyPublisher<[Comment], TvShowsRepositoryError> {
        let comments = comments.filter { $0.userId == userId }

        return Just(comments.sorted(by: { $0.date > $1.date }))
            .delay(for: simulatedDelay, scheduler: RunLoop.main)
            .setFailureType(to: TvShowsRepositoryError.self)
            .eraseToAnyPublisher()
    }

    func postComment(_ comment: Comment) -> AnyPublisher<Void, TvShowsRepositoryError> {
        comments.append(comment)

        return Empty()
            .delay(for: simulatedDelay, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
