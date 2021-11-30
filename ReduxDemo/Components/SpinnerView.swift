//
//  SpinnerView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 30/11/2021.
//

import SwiftUI

struct SpinnerView: View {
    let message: String?

    init(_ message: String? = nil) {
        self.message = message
    }

    var body: some View {
        if let message = message {
            ProgressView(label: { Text(message).foregroundColor(.yellow) })
        } else {
            ProgressView()
        }
    }
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
