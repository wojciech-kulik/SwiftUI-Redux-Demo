//
//  CommentsStateAction.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 29/11/2021.
//

import Foundation

enum CommentsStateAction: ActionProtocol {
    case fetchEpisodeComments(id: UUID)
    case didReceiveEpisodeComments([Comment], episodeId: UUID)
    case postComment(Comment)
    case updateNewCommentText(String)
}
