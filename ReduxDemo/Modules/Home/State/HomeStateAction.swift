//
//  HomeStateAction.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

enum HomeStateAction: Action {
    case fetchUpcomingEpisodes
    case didReceiveUpcomingEpisodes([UpcomingEpisode])
    case updateSearchText(String)
    case filterEpisodes(phrase: String)
}
