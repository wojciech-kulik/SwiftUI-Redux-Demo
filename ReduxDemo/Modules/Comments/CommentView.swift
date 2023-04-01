//
//  CommentView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct CommentView: View {
    let canPresentProfile: Bool
    let comment: Comment

    @EnvironmentObject var store: Store<AppState>
    private var state: CommentsState? { store.state.screenState(for: .comments(episodeId: comment.episodeId)) }

    @ViewBuilder
    var avatarView: some View {
        if canPresentProfile {
            Button {
                store.dispatch(AppState.Action.showScreen(.userProfile(id: comment.userId, sourceCommentId: comment.id)))
            } label: {
                Image(comment.avatar)
                    .resizable()
                    .frame(width: 60.0, height: 60.0)
            }
        } else {
            Image(comment.avatar)
                .resizable()
                .frame(width: 60.0, height: 60.0)
        }
    }

    var commentView: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            Text("\(comment.name) • \(comment.date, format: .relative(presentation: .named))")
                .fontWeight(.bold)
            Text(comment.text)
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 16.0) {
            avatarView
            commentView
        }.sheet(isPresented: Binding(
            get: { canPresentProfile && comment.userId == state?.presentedUserProfileId && comment.id == state?.selectedCommentId },
            set: {
                guard !$0 else { return }
                store.dispatch(AppState.Action.dismissScreen(.userProfile(id: comment.userId, sourceCommentId: comment.id)))
            }
        )) {
            UserDetailsView(userId: comment.userId, sourceCommentId: comment.id)
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(canPresentProfile: true, comment: .mock)
            .environmentObject(store)
    }
}
