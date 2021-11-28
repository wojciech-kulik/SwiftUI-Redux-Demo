//
//  EpisodeDetailsAction.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

enum EpisodeDetailsAction: Action {
    case fetchEpisodeDetails(id: UUID)
    case receivedEpisodeDetails(EpisodeDetails)
    case fetchEpisodeComments(id: UUID)
    case receivedEpisodeComments([Comment], episodeId: UUID)
}
