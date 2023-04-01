//
//  AppScreenCore.swift
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

extension AppScreen {

    enum State: Codable {
        case splashScreen
        case home(Home.State)
        case episode(EpisodeDetailsFeature.State)
        case userProfile(UserDetails.State)
    }

    static let reducer: Reducer<State> = { state, action in
        switch state {
        case .splashScreen: return .splashScreen
        case .home(let state): return .home(Home.reducer(state, action))
        case .episode(let state): return .episode(EpisodeDetailsFeature.reducer(state, action))
        case .userProfile(let state): return .userProfile(UserDetails.reducer(state, action))
        }
    }
}
