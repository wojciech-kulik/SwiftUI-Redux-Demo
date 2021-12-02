//
//  View+Modifiers.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

extension View {
    func onLoad(_ action: @escaping () -> Void) -> some View {
        modifier(ViewDidLoadModifier(action))
    }

    func addReplayButton() -> some View {
        modifier(ReplayButtonModifier())
    }
}
