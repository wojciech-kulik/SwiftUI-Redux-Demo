//
//  UserDetailsView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct UserDetailsView: View {
    let userId: UUID
    let sourceCommentId: UUID

    @EnvironmentObject var store: Store<AppState>
    private var state: UserDetailsState? { store.state.screenState(for: .userProfile(id: userId, sourceCommentId: sourceCommentId)) }

    var body: some View {
        if let state = state, let userDetails = state.details, !state.isLoading {
            ScrollView {
                VStack(spacing: 8) {
                    Image(userDetails.avatar)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)

                    Text(userDetails.name)
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Joined: \(userDetails.signUpDate, format: .relative(presentation: .named))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("Location: \(userDetails.location)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("Comments")
                        .font(.callout)
                        .foregroundColor(.yellow)
                        .padding(.top, 32.0)

                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(state.comments) {
                            CommentView(canPresentProfile: false, comment: $0)
                                .padding(.top, 24.0)
                        }
                    }
                }
                .padding(16.0)
                .padding(.top, 24.0)
            }
        } else {
            SpinnerView("Loading Profile")
                .onLoad { store.dispatch(UserDetailsState.Action.fetchUserProfile(userId: userId)) }
        }
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(userId: User.mock.id, sourceCommentId: Comment.mock.id)
            .environmentObject(store)
    }
}
