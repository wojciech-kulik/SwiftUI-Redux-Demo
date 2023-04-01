//
//  UserDetailsCore.swift
//  ReduxDemo
//
//  Created by Hugues Telolahy on 01/04/2023.
//

import Foundation

struct UserDetails {

    struct State: Codable {
        let userId: UUID
        let details: User?
        let comments: [Comment]
        let isLoading: Bool
    }

    enum Action: ActionProtocol {
        case fetchUserProfile(userId: UUID)
        case didReceiveUserProfile(user: User, comments: [Comment])
    }

    static let reducer: Reducer<State> = { state, action in
        guard let action = action as? Action else { return state }

        switch action {
        case .fetchUserProfile(let id):
            return .init(
                userId: id,
                details: nil,
                comments: [],
                isLoading: true
            )
        case .didReceiveUserProfile(let userDetails, let comments):
            return .init(
                userId: state.userId,
                details: userDetails,
                comments: comments,
                isLoading: false
            )
        }
    }
}

extension UserDetails.State {
    init(id: UUID) {
        userId = id
        details = nil
        comments = []
        isLoading = true
    }
}

