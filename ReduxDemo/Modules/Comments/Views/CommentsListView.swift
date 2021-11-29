//
//  CommentsListView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 29/11/2021.
//

import SwiftUI

struct CommentsListView: View {
    @State var episodeId: UUID
    
    @EnvironmentObject var store: Store<AppState>

    var state: CommentsState? { store.state.state(for: .episode(id: episodeId), type: EpisodeDetailsState.self)?.comments }

    @ViewBuilder
    var body: some View {
        if let state = state {
            if state.isLoading == true {
                HStack {
                    Spacer()
                    ProgressView().tint(.yellow)
                    Spacer()
                }
                .onLoad { store.dispatch(CommentsStateAction.fetchEpisodeComments(id: episodeId)) }
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
                        HStack {
                            Spacer()
                            Text("Post the first comment!")
                                .foregroundColor(.gray)
                            Spacer()
                        }
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
