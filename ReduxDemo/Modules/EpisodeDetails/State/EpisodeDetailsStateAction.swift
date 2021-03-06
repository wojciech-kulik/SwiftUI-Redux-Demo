//
//  EpisodeDetailsStateAction.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

enum EpisodeDetailsStateAction: Action {
    case fetchEpisodeDetails(id: UUID)
    case didReceiveEpisodeDetails(EpisodeDetails)
}
