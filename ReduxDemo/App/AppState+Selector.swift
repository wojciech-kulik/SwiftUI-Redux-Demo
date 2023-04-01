//
//  AppState+Selector.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

extension AppState {
    func screenState<State>(for screen: AppScreen) -> State? {
        screens
            .compactMap {
                switch ($0, screen) {
                case (.home(let state), .home): return state as? State
                case (.episode(let state), .episode(let id)) where state.episodeId == id: return state as? State
                case (.episode(let state), .comments(let id)) where state.episodeId == id: return state.comments as? State
                case (.userProfile(let state), .userProfile(let id, _)) where state.userId == id: return state as? State
                default: return nil
                }
            }
            .first
    }
}
