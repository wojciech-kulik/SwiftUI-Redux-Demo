//
//  AppStateReducer.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

extension AppState {
    static let reducer: Reducer<Self> = { state, action in
        AppState(
            activeScreens: ActiveScreensState.reducer(state.activeScreens, action)
        )
    }
}
