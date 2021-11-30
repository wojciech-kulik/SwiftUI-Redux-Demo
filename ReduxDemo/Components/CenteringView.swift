//
//  CenteringView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 30/11/2021.
//

import SwiftUI

struct CenteringView<Content: View>: View {
    var content: () -> Content

    init(_ content: Content) {
        self.content = { content }
    }

    init(_ content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        HStack {
            Spacer()
            content()
            Spacer()
        }
    }
}

struct CenteringView_Previews: PreviewProvider {
    static var previews: some View {
        CenteringView { Text("Test") }
    }
}
