//
//  AppScreenState.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

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
        case (.userProfile(let state), .episode(let id)): return state.userId == id
        case (.splashScreen, _): return false
        case (.home, _): return false
        case (.episode, _): return false
        case (.userProfile, _): return false
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
