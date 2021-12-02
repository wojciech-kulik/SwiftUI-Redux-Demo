//
//  ReplayButtonModifier.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 02/12/2021.
//

import Foundation
import SwiftUI

struct ReplayButtonModifier: ViewModifier {
    @State var isReplayFinishedAlertVisible = false
    @State var isReplayStartAlertVisible = false

    @ObservedObject private var stateHolder: ReplayFinishedStateHolder = replayFinishedStateHolder

    func body(content: Content) -> some View {
        content.toolbar(content: {
            ToolbarItem {
                Button(
                    action: { isReplayStartAlertVisible = true },
                    label: {
                        Image(systemName: "clock.arrow.circlepath")
                            .foregroundColor(stateHolder.isReplayButtonDisabled ? .secondary : .yellow)
                    }
                ).disabled(stateHolder.isReplayButtonDisabled)
            }
        })
        .alert(
            "Do you want to replay \(timelineRecorder.totalSteps) states (duration: \(Int(timelineRecorder.totalLength))s)?",
            isPresented: $isReplayStartAlertVisible,
            actions: {
                Button("Cancel") {}
                Button("Replay") {
                    stateHolder.isReplayButtonDisabled = true
                    timelineRecorder.replayTimeline {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                            stateHolder.isReplayButtonDisabled = false
                            stateHolder.isFinished = true
                        }
                    }
                }
            }
        )
        .alert("Timeline has finished!", isPresented: $stateHolder.isFinished, actions: {
            Button("OK") {}
        })
    }
}

// We need to store state somewhere, because it will be discarded during timeline replay.
fileprivate final class ReplayFinishedStateHolder: ObservableObject {
    @Published var isFinished = false
    @Published var isReplayButtonDisabled = false
}
fileprivate let replayFinishedStateHolder = ReplayFinishedStateHolder()
