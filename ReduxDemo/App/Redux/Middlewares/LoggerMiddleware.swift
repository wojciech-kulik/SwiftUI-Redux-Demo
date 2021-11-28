//
//  LoggerMiddleware.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Combine

extension Middlewares {
    static let logger: Middleware<AppState> = { state, action in
        let stateDescription = "\(state)".replacingOccurrences(of: "ReduxDemo.", with: "")
        print("Action: \(action)\nState: \(stateDescription)\n")

        return Empty().eraseToAnyPublisher()
    }
}
