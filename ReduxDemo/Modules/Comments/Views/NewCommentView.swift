//
//  NewCommentView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 29/11/2021.
//

import SwiftUI

struct NewCommentView: View {
    @State var newCommentText: String = ""
    
    @EnvironmentObject var store: Store<AppState>

    var body: some View {
        UITextView.appearance().backgroundColor = .clear

        return VStack {
            TextEditor(text: $newCommentText)
                .background(Color(hex: "#1a1a1a"))
                .foregroundColor(.white)
                .frame(height: 120)
                .cornerRadius(6.0)

            HStack {
                Spacer()
                Button("Post") {
                    // TODO
                }
                .disabled(newCommentText.isEmpty)
                .padding(.top, 8)
                .foregroundColor(.yellow)
                .buttonStyle(.bordered)
                .controlSize(.large)
                .tint(.red)
            }
        }
    }
}

struct NewCommentView_Previews: PreviewProvider {
    static var previews: some View {
        NewCommentView()
            .environmentObject(store)
    }
}
