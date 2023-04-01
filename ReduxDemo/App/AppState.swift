//
//  AppState.swift
//  ReduxDemo
//
//  Created by Hugues Telolahy on 01/04/2023.
//

import Foundation

struct AppState: Codable {
    let screens: [AppScreen.State]
}

extension AppState {

    enum Action: ActionProtocol {
        case showScreen(AppScreen)
        case dismissScreen(AppScreen)
    }

    static let reducer: Reducer<Self> = { state, action in
        var screens = state.screens

        // Update visible screens
        if let action = action as? Action {
            switch action {
            case .showScreen(.splashScreen),
                    .dismissScreen(.home),
                    .dismissScreen(.splashScreen): screens = [.splashScreen]
            case .showScreen(.home): screens = [.home(.init())]
            case .showScreen(.episode(let id)): screens += [.episode(.init(id: id))]
            case .showScreen(.userProfile(let id, _)): screens += [.userProfile(.init(id: id))]
            case .showScreen(.comments): ()
            case .dismissScreen(let screen): screens = screens.filter { $0 != screen }
            }
        }

        // Reduce each screen state
        screens = screens.map { AppScreen.reducer($0, action) }

        return .init(screens: screens)
    }
}

extension AppState {
    init() {
        screens = [.splashScreen]
    }
}