//
//  Store.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation
import Combine
import SwiftUI

protocol ActionProtocol {}

struct NoOpAction: ActionProtocol {}

typealias Reducer<State> = (State, ActionProtocol) -> State
typealias Middleware<State> = (State, ActionProtocol) -> AnyPublisher<ActionProtocol, Never>

final class Store<State>: ObservableObject {
    var isEnabled = true

    @Published private(set) var state: State

    private var subscriptions: [UUID: AnyCancellable] = [:]

    private let queue = DispatchQueue(label: "pl.wojciechkulik.ReduxDemo.store", qos: .userInitiated)
    private let reducer: Reducer<State>
    private let middlewares: [Middleware<State>]

    init(
        initial state: State,
        reducer: @escaping Reducer<State>,
        middlewares: [Middleware<State>]
    ) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
    }

    func restoreState(_ state: State) {
        self.state = state
    }

    func dispatch(_ action: ActionProtocol) {
        guard isEnabled else { return }

        queue.sync {
            self.dispatch(self.state, action)
        }
    }

    private func dispatch(_ currentState: State, _ action: ActionProtocol) {
        let newState = reducer(currentState, action)

        middlewares.forEach { middleware in
            let key = UUID()
            middleware(newState, action)
                .receive(on: RunLoop.main)
                .handleEvents(receiveCompletion: { [weak self] _ in self?.subscriptions.removeValue(forKey: key) })
                .sink(receiveValue: dispatch)
                .store(in: &subscriptions, key: key)
        }

        withAnimation {
            state = newState
        }
    }
}
