//
//  HomeStateAction.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

enum HomeStateAction: Action {
    case fetchUpcomingEpisodes
    case receivedUpcomingEpisodes([UpcomingEpisode])
    case updateSearchText(String)
    case filterEpisodes(phrase: String)
}
