//
//  AppState+ScreenStateSelector.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

extension AppState {
    func state<State>(for screen: AppScreen, type: State.Type) -> State? {
        return activeScreens.screens
            .compactMap {
                switch ($0, screen) {
                case (.home(let state), .home): return state as? State
                case (.episode(let state), .episode(let id)) where state.episodeId == id: return state as? State
                case (.userProfile(let state), .userProfile(let id)) where state.userId == id: return state as? State
                default: return nil
                }
            }
            .first
    }
}
