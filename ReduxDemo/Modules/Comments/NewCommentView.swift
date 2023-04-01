//
//  NewCommentView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 29/11/2021.
//

import SwiftUI

struct NewCommentView: View {
    let episodeId: UUID

    @FocusState var isTextEditorFocused: Bool
    @EnvironmentObject var store: Store<AppState>
    private var state: CommentsState? { store.state.screenState(for: .comments(episodeId: episodeId)) }

    @ViewBuilder
    var body: some View {
        if let state = state {
            createCommentBox(state: state)
        }
    }

    private func createCommentBox(state: CommentsState) -> some View {
        UITextView.appearance().backgroundColor = .clear

        return VStack {
            TextEditor(text: Binding(get: { state.newCommentText }, set: { store.dispatch(CommentsState.Action.updateNewCommentText($0)) }))
                .focused($isTextEditorFocused)
                .background(Color(hex: "#1a1a1a"))
                .frame(height: 120)
                .cornerRadius(6.0)

            HStack {
                Spacer()
                Button("Post") {
                    isTextEditorFocused = false
                    store.dispatch(CommentsState.Action.postComment(Comment(
                        id: UUID(),
                        userId: User.mock.id,
                        avatar: User.mock.avatar,
                        name: User.mock.name,
                        date: Date(),
                        text: state.newCommentText,
                        episodeId: episodeId
                    )))
                }
                .disabled(state.newCommentText.isEmpty)
                .padding(.top, 8)
                .foregroundColor(.yellow)
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
        }
    }
}

struct NewCommentView_Previews: PreviewProvider {
    static var previews: some View {
        NewCommentView(episodeId: EpisodeDetails.mockGameOfThrones.id)
            .environmentObject(store)
    }
}
