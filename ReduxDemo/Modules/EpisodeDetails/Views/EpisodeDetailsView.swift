//
//  EpisodeDetailsView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

fileprivate var lastState: EpisodeDetailsState?

struct EpisodeDetailsView: View {
    @State var details: EpisodeDetails
    @State var comment: String = ""
    @EnvironmentObject var store: Store<AppState>

    var state: EpisodeDetailsState? {
        let state = store.state.state(for: .episode(id: details.id), type: EpisodeDetailsState.self)
        lastState = state ?? lastState
        return lastState
    }

    var headerView: some View {
        VStack(spacing: 0.0) {
            Image(details.photo)
                .resizable()
                .frame(height: 220)
                .aspectRatio(contentMode: .fill)

            Text(details.title)
                .font(.title)
                .padding()

            Text("S\(details.season, specifier: "%02d")E\(details.episode, specifier: "%02d") • \(details.releaseDate, format: .relative(presentation: .named))")
                .font(.subheadline)
                .foregroundColor(.yellow)
        }
    }

    @ViewBuilder
    var descriptionView: some View {
        Text("Description")
            .foregroundColor(.yellow)
            .padding(.top, 20.0)
            .padding(.vertical)

        Text(details.episodeDescription)
    }

    var commentBox: some View {
        TextEditor(text: $comment)
            .background(Color(hex: "#1a1a1a"))
            .foregroundColor(.white)
            .frame(height: 120)
            .cornerRadius(6.0)
    }

    @ViewBuilder
    var commentsView: some View {
        Text("Comments")
            .foregroundColor(.yellow)
            .padding(.top, 20.0)
            .padding(.vertical)

        if state?.isLoadingComments == true {
            HStack {
                Spacer()
                ProgressView().tint(.yellow)
                Spacer()
            }
        } else if let state = state {
            commentBox
            ForEach(state.comments) { comment in
                CommentView(
                    canPresentProfile: true,
                    comment: comment,
                    isUserProfileVisible: state.presentedUserProfileId == comment.userId && state.selectedCommentId == comment.id
                )
                .padding(.vertical, 8.0)
            }.padding(.top, 24.0)
        } else {
            commentBox
            HStack {
                Spacer()
                Text("Post the first comment!")
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.top, 24.0)
        }
    }

    var body: some View {
        UITextView.appearance().backgroundColor = .clear
        UIScrollView.appearance().keyboardDismissMode = .onDrag

        return ScrollView {
            VStack(alignment: .leading, spacing: 0.0) {
                headerView

                VStack(alignment: .leading, spacing: 0.0) {
                    descriptionView
                    commentsView
                }.padding(.horizontal, 24.0)
            }
        }
        .ignoresSafeArea(edges: [.top])
        .tint(.black)
        .accentColor(.yellow)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in

        }
        .onLoad { store.dispatch(EpisodeDetailsAction.fetchEpisodeComments(id: details.id)) }
    }
}

struct EpisodeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsView(details: .mockGameOfThrones)
            .environmentObject(store)
    }
}
