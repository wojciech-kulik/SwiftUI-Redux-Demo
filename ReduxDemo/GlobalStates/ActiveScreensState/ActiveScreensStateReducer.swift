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

        // Update visible screens
        if let action = action as? ActiveScreensStateAction {
            switch action {
            case .showScreen(.splashScreen), .dismissScreen(.home), .dismissScreen(.splashScreen): screens = [.splashScreen]
            case .showScreen(.home): screens = [.home(Home.State())]
            case .showScreen(.episode(let id)): screens += [.episode(EpisodeDetailsFeature.State(id: id))]
            case .showScreen(.userProfile(let id, _)): screens += [.userProfile(UserDetailsState(id: id))]
            case .showScreen(.comments): ()
            case .dismissScreen(let screen): screens = screens.filter { $0 != screen }
            }
        }

        // Reduce each screen state
        screens = screens.map { AppScreenState.reducer($0, action) }

        return ActiveScreensState(screens: screens)
    }
}
