//
//  LoggerMiddleware.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Combine

final class LoggerMiddleware {

    func middleware(state: AppState, action: ActionProtocol) -> AnyPublisher<ActionProtocol, Never> {
        let stateDescription = "\(state)".replacingOccurrences(of: "ReduxDemo.", with: "")
        print("➡️ \(action)\n✅ \(stateDescription)\n")

        return Empty().eraseToAnyPublisher()
    }
}
