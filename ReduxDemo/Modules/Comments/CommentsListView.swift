//
//  CommentsListView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 29/11/2021.
//

import SwiftUI

struct CommentsListView: View {
    let episodeId: UUID
    
    @EnvironmentObject var store: Store<AppState>
    private var state: CommentsState? { store.state.screenState(for: .comments(episodeId: episodeId)) }

    @ViewBuilder
    var body: some View {
        if let state = state {
            if state.isLoading == true {
                CenteringView(SpinnerView())
                    .onLoad { store.dispatch(CommentsState.Action.fetchEpisodeComments(id: episodeId)) }
            } else {
                VStack(alignment: .leading) {
                    NewCommentView(episodeId: episodeId)

                    if !state.comments.isEmpty {
                        ForEach(state.comments) { comment in
                            CommentView(
                                canPresentProfile: true,
                                comment: comment
                            )
                            .padding(.vertical, 8.0)
                        }.padding(.top, 24.0)
                    } else {
                        CenteringView(Text("Post the first comment!"))
                            .foregroundColor(.secondary)
                            .padding(.top, 24.0)
                    }
                }
            }
        }
    }
}

struct CommentsListView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsListView(episodeId: UUID())
            .environmentObject(store)
    }
}
