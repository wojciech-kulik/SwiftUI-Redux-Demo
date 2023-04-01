//
//  TimelineRecorderMiddleware.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 02/12/2021.
//

import Combine
import Foundation

final class TimelineRecorderMiddleware {
    var totalSteps: Int { timeline.count }
    var totalLength: TimeInterval { timeline.map(\.timeOffset).reduce(0.0, +) }

    private var timeline: [(timeOffset: TimeInterval, state: AppState)] = []
    private var shouldRecord = true
    private var lastStateChangeDate = Date()

    init() {
        timeline = [(0.0, AppState())]
    }

    func middleware(state: AppState, action: ActionProtocol) -> AnyPublisher<ActionProtocol, Never> {
        if shouldRecord {
            timeline.append((timeline.isEmpty ? 0.0 : Date().timeIntervalSince(lastStateChangeDate), state))
        }

        lastStateChangeDate = Date()

        return Empty().eraseToAnyPublisher()
    }

    func replayTimeline(completion: @escaping () -> ()) {
        shouldRecord = false
        store.isEnabled = false
        replayNextStep(completion: completion)
    }

    private func replayNextStep(completion: @escaping () -> ()) {
        guard let step = timeline.first else {
            store.isEnabled = true
            shouldRecord = true
            return completion()
        }

        timeline.remove(at: 0)

        DispatchQueue.main.asyncAfter(deadline: .now() + step.timeOffset) {
            store.restoreState(step.state)
            self.replayNextStep(completion: completion)
        }
    }
}
