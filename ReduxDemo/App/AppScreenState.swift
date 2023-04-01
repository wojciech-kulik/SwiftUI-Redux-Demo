//
//  AppScreenState.swift
//  ReduxDemo
//
//  Created by Hugues Telolahy on 01/04/2023.
//

import Foundation

enum AppScreen: Equatable {
    case splashScreen
    case home
    case episode(id: UUID)
    case userProfile(id: UUID, sourceCommentId: UUID)
    case comments(episodeId: UUID)
}

enum AppScreenState: Codable {
    case splashScreen
    case home(HomeState)
    case episode(EpisodeDetailsState)
    case userProfile(UserDetailsState)
}

extension AppScreenState {
    static func == (lhs: AppScreenState, rhs: AppScreen) -> Bool {
        switch (lhs, rhs) {
        case (.splashScreen, .splashScreen): return true
        case (.home, .home): return true
        case (.episode(let state), .episode(let id)): return state.episodeId == id
        case (.userProfile(let state), .userProfile(let id, _)): return state.userId == id
        default: return false
        }
    }

    static func == (lhs: AppScreen, rhs: AppScreenState) -> Bool {
        rhs == lhs
    }

    static func != (lhs: AppScreen, rhs: AppScreenState) -> Bool {
        !(lhs == rhs)
    }

    static func != (lhs: AppScreenState, rhs: AppScreen) -> Bool {
        !(lhs == rhs)
    }
}

