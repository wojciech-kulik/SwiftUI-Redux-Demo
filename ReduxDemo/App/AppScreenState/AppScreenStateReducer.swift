//
//  AppScreenStateReducer.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

extension AppScreenState {
    static let reducer: Reducer<Self> = { state, action in
        switch state {
        case .splashScreen: return .splashScreen
        case .home(let state): return .home(HomeState.reducer(state, action))
        case .episode(let state): return .episode(EpisodeDetailsState.reducer(state, action))
        case .userProfile(let state): return .userProfile(UserDetailsState.reducer(state, action))
        }
    }
}
