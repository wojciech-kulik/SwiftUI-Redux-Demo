//
//  AppScreenState.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

enum AppScreenState: Codable {
    case splashScreen
    case home(Home.State)
    case episode(EpisodeDetailsFeature.State)
    case userProfile(UserDetails.State)
}

extension AppScreenState: CustomStringConvertible {
    var description: String {
        switch self {
        case .splashScreen: return "splashScreen"
        case .home(let state): return "home(isLoading=\(state.isLoading))"
        case .episode(let state): return "episode(\(state.details?.title ?? "-"), isLoading=\(state.isLoading), isLoadingComments=\(state.comments.isLoading)"
        case .userProfile(let state): return "userProfile(\(state.details?.name ?? "-"), isLoading=\(state.isLoading))"
        }

    }
}

extension AppScreenState {
    static func == (lhs: AppScreenState, rhs: AppScreen) -> Bool {
        switch (lhs, rhs) {
        case (.splashScreen, .splashScreen): return true
        case (.home, .home): return true
        case (.episode(let state), .episode(let id)): return state.episodeId == id
        case (.userProfile(let state), .userProfile(let id, _)): return state.userId == id
        case (.splashScreen, _), (.home, _), (.episode, _), (.userProfile, _): return false
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
