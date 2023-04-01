//
//  ViewDidLoadModifier.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    private let action: () -> Void

    @State private var didLoad = false

    init(_ action: @escaping () -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if !didLoad {
                didLoad.toggle()
                action()
            }
        }
    }
}
