//
//  ActiveScreensStateReducer.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

extension ActiveScreensState {
    static let reducer: Reducer<Self> = { state, action in
        var screens = state.screens

        if let action = action as? ActiveScreensStateAction {
            switch action {
            case .showScreen(.splashScreen), .dismissScreen(.home), .dismissScreen(.splashScreen): screens = [.splashScreen]
            case .showScreen(.home): screens = [.home(HomeState())]
            case .showScreen(.episode(let id)): screens += [.episode(EpisodeDetailsState(id: id))]
            case .showScreen(.userProfile(let id, _)): screens += [.userProfile(UserDetailsState(id: id))]
            case .dismissScreen(let screen): screens = screens.filter { $0 != screen }
            }
        }

        // Forward actions to state reducers (cascade)
        screens = screens.map {
            switch $0 {
            case .splashScreen: return $0
            case .home(let state): return .home(HomeState.reducer(state, action))
            case .episode(let state): return .episode(EpisodeDetailsState.reducer(state, action))
            case .userProfile(let state): return .userProfile(UserDetailsState.reducer(state, action))
            }
        }

        return ActiveScreensState(screens: screens)
    }
}
