//
//  AppState.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct AppState: Codable {
    let activeScreens: ActiveScreensState
}

extension AppState {
    init() {
        activeScreens = ActiveScreensState()
    }
}
