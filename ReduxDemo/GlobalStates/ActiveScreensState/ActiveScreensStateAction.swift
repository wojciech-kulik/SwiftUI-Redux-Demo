//
//  ActiveScreensStateAction.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

enum AppScreen {
    case splashScreen
    case home
    case episode(id: UUID)
    case userProfile(id: UUID, sourceCommentId: UUID)
    case comments(episodeId: UUID)
}

enum ActiveScreensStateAction: Action {
    case showScreen(AppScreen)
    case dismissScreen(AppScreen)
}
