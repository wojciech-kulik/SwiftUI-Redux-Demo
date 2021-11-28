//
//  ActiveScreensState.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct ActiveScreensState: Codable {
    let screens: [AppScreenState]
}

extension ActiveScreensState {
    init() {
        screens = [.splashScreen]
    }
}
