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

    var state: UserDetailsState? {
        store.state.state(for: .userProfile(id: userId, sourceCommentId: sourceCommentId), type: UserDetailsState.self)
    }

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
                        .foregroundColor(.gray)

                    Text("Location: \(userDetails.location)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("Comments")
                        .font(.callout)
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
            ProgressView(label: { Text("Loading Profile").foregroundColor(.yellow) })
                .tint(.yellow)
                .onLoad { store.dispatch(UserDetailsStateAction.fetchUserProfile(userId: userId)) }
        }
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(userId: User.mock.id, sourceCommentId: Comment.mock.id)
            .environmentObject(store)
    }
}
