//
//  CommentsStateAction.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 29/11/2021.
//

import Foundation

enum CommentsStateAction: Action {
    case fetchEpisodeComments(id: UUID)
    case receivedEpisodeComments([Comment], episodeId: UUID)
}
