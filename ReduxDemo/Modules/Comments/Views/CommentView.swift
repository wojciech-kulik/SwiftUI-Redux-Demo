//
//  CommentView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct CommentView: View {
    let canPresentProfile: Bool

    @State var comment: Comment

    @EnvironmentObject var store: Store<AppState>

    var state: CommentsState? { store.state.state(for: .episode(id: comment.episodeId), type: EpisodeDetailsState.self)?.comments }

    var body: some View {
        HStack(alignment: .top, spacing: 16.0) {
            if canPresentProfile {
                Button {
                    store.dispatch(ActiveScreensStateAction.showScreen(.userProfile(id: comment.userId, sourceCommentId: comment.id)))
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

            VStack(alignment: .leading, spacing: 6.0) {
                Text("\(comment.name) • \(comment.date, format: .relative(presentation: .named))")
                    .fontWeight(.bold)
                Text(comment.text)
            }
        }.sheet(isPresented: Binding(
            get: { comment.userId == state?.presentedUserProfileId && comment.id == state?.selectedCommentId },
            set: {
                guard !$0 else { return }
                store.dispatch(ActiveScreensStateAction.dismissScreen(.userProfile(id: comment.userId, sourceCommentId: comment.id)))
            }
        )) {
            UserDetailsView(user: .mock)
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(canPresentProfile: true, comment: .mock)
            .environmentObject(store)
    }
}
