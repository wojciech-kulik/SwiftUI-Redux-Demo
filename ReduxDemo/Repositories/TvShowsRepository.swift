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
    private let shows = [TvShow.mockGameOfThrones, .mockBreakingBad]

    func fetchUpcomingEpisodes() -> AnyPublisher<[UpcomingEpisode], TvShowsRepositoryError> {
        Just([UpcomingEpisode.mockGameOfThrones, .mockBreakingBad])
            .delay(for: 2.0, scheduler: DispatchQueue.main)
            .setFailureType(to: TvShowsRepositoryError.self)
            .eraseToAnyPublisher()
    }

    func fetchEpisodeDetails(episodeId: UUID) -> AnyPublisher<EpisodeDetails, TvShowsRepositoryError> {
        if let episode = EpisodeDetails.allMocks.first(where: { $0.id == episodeId }) {
            return Just(episode)
                .delay(for: 2.0, scheduler: DispatchQueue.main)
                .setFailureType(to: TvShowsRepositoryError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: TvShowsRepositoryError.couldNotFind)
                .delay(for: 2.0, scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }

    func fetchComments(for episodeId: UUID) -> AnyPublisher<[Comment], TvShowsRepositoryError> {
        let comments = Comment.allMocks.filter({ $0.episodeId == episodeId })

        if !comments.isEmpty {
            return Just(comments)
                .delay(for: 2.0, scheduler: DispatchQueue.main)
                .setFailureType(to: TvShowsRepositoryError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: TvShowsRepositoryError.couldNotFind)
                .delay(for: 2.0, scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}
